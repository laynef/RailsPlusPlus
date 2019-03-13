class GlobalController < ApplicationController
  include ExceptionHandler
  include Response

  def default_per_page
    25
  end

  def model
    self.class.to_s.split("::").select {|e| /Controller/.match(e) }.first.chomp("Controller").singularize.constantize
  end

  def index
    resp = index_response
    past_pages = resp[:last_page] < resp[:current_page]
    error = {error: "Past the amount of pages available"}
    status = past_pages ? :bad_request : :ok
    data = past_pages ? error : resp
    data = handle_includes(data) if params[:include] && !past_pages
    render_json(data, status)
  end

  def show
    data = model.find(params[:id] || 0)
    data = handle_includes(data) if params[:include]
    render_json(data, :ok)
  end

  def create
    data = model.create(create_params)
    render_json(data, :created)
  end

  def update
    data = model.where(id: params[:id] || 0).update(update_params).first
    render_json(data, :ok)
  end

  def destroy
    model.destroy(params[:id] || 0)
    render_json(nil, :no_content)
  end

  def bulk_csv_create
    data = model.create(csv_to_json)
    render_json(data, :created)
  end

  def bulk_create
    data = model.create(bulk_create_params[:bulk])
    render_json(data, :created)
  end

  def bulk_update
    data = model.where(id: bulk_update_params[:bulk].map {|e| e[:id] }).update(bulk_update_params[:bulk])
    render_json(data, :ok)
  end

  def bulk_destroy
    ids = comma_separated(:ids)
    are_ids = array_of_integers(ids)
    if ids.is_a?(Array) && are_ids
      array = model.where(id: ids)
      if array.length == ids.length
        array.delete_all
        render_json(nil, :no_content)
      else
        render_json({ error: "Not all ids are valid" }, :bad_request)
      end
    else
      render_json({ error: "Must pass in a string of ids that are comma separated" }, :bad_request)
    end
  end

  private

  def array_of_integers array
    array.all? { |e| is_i?(e) }
  end

  def is_i? string
    !!(string =~ /\A[-+]?[0-9]+\z/)
  end

  def csv_to_json param_key=:file, separated_by=","
    lines = params[param_key].split("\n")
    keys = lines[0].split(separated_by)
    rows = lines.slice(1).map {|e| e.split(separated_by) }
    rows.map {|e| e.each_with_index.inject({}) {|acc, (e, i)| acc.merge(:"#{keys[i]}" => e) } }
  end

  def create_params
    bl = array_to_hash(black_list_create)
    params.permit(*get_model_key.reject {|e| bl[e.to_sym] })
  end

  def update_params
    bl = array_to_hash(black_list_update)
    params.permit(*get_model_key.reject {|e| bl[e.to_sym] })
  end

  def bulk_create_params
    params.permit(bulk: get_model_key)
  end

  def bulk_update_params
    params.permit(bulk: get_model_key)
  end

  def bulk_destroy_params
    params.permit(bulk: [:id])
  end

  def black_list_create
    %i[id created_at updated_at]
  end

  def black_list_update
    %i[id created_at updated_at]
  end

  def array_to_hash array
    array.each_with_object({}) do |e, acc|
      acc[e] = true
      acc
    end
  end

  def handle_pagination
    limit = (params[:limit] || default_per_page).to_i
    offset = (params[:offset] || 0).to_i
    page = (params[:page] || 1).to_i
    order = params[:order] ? get_order : "id ASC"

    data = model.limit(limit).offset(offset).offset((page - 1) * limit)
    data = data.where(get_where) if params[:where]
    data = data.includes(*get_includes) if params[:include]
    data = data.order(order)
    data = data.all
    data
  end

  def handle_pagination_count
    data = model
    data = data.where(get_where) if params[:where]
    data.count
  end

  def handle_includes data
    data.to_json(include: get_includes)
  end

  def index_response
    page = (params[:page] || 1).to_i
    per_page = (params[:limit] || default_per_page).to_i
    total = handle_pagination_count
    path = request.original_url
    path_path = add_pg_qs(path)
    last = (total / per_page.to_f).ceil
    nxt = (page + 1) > last ? nil : (page + 1)
    prev = (page - 1) == 0 ? nil : (page - 1)
    last = last == 0 ? 1 : last
    data = handle_pagination
    data_first = data.first
    data_last = data.last

    {
      data:           data,
      from:           data_first ? data_first.id : nil,
      to:             data_last ? data_last.id : nil,
      total:          total,
      path:           path,
      current_page:   page,
      per_page:       per_page,
      last_page:      last,
      first_page_url: path_path + "1",
      last_page_url:  path_path + last.to_s,
      next_page_url:  nxt ? (path_path + nxt.to_s) : nil,
      prev_page_url:  prev ? (path_path + prev.to_s) : nil
    }
  end

  def add_pg_qs str
    has_qs = /\?/.match(str)
    return "#{str}?page=" unless has_qs

    before_qs, after = str.split("?")
    after_qs = after.split("&").reject {|e| /page\=/.match(e) }
    after_qs.push("page=")
    "#{before_qs}?#{after_qs.join('&')}"
  end

  def get_includes
    comma_separated(:include).map do |e|
      semi = e.split(":")
      semi.length > 1 ? array_depth(semi) : semi.first.to_sym
    end
  end

  def array_depth(array, acc={})
    if array.length > 2
      key = array.shift
      acc[key.to_sym] = array_depth(array, {})
    else
      key, val = array
      acc[key.to_sym] = val.to_sym
    end
    acc
  end

  def get_order
    params[:order].split(",").flat_map {|e| e.split(":") }.join(" ")
  end

  def get_where
    arrays = params[:where].split(",").map {|e| e.split(":") }
    arrays.each_with_object({}) do |item, acc|
      key, val = item
      acc[key] = val
    end
  end

  def comma_separated key
    params[key].split(",")
  end

  def get_model_key
    model.columns.map {|e| e.name.to_sym }
  end
end
