module Response
  def render_json data, status
    data = JSON.parse(data) if data.is_a?(String)
    data[:data] = data[:data].map {|e| deleting(e) } if data && data[:data] && !data[:data].empty?
    data = deleting(data) if data && !data[:data]
    render json: data, status: status
  end

  private

  def hide_keys
    [
      :password_digest,
    ]
  end

  def dictionary array
    array.each_with_object({}) do |e, acc|
      acc[e] = true
      acc
    end
  end

  def prepare_json collection
    JSON.parse(collection.to_json).symbolize_keys
  end

  def object_delete(json, lookup)
    json.each do |k, v|
      if v.is_a?(Hash)
        json[k] = object_delete(prepare_json(v), lookup)
      elsif v.is_a?(Array) && v.all? { |f| f.is_a?(Hash) }
        json[k] = json[k].map {|val| object_delete(prepare_json(val), lookup) }
      elsif lookup[k]
        json.delete(k)
      end
    end
    json
  end

  def deleting(hash)
    json = prepare_json(hash)
    lookup = dictionary(hide_keys)
    object_delete(json, lookup)
  end
end
