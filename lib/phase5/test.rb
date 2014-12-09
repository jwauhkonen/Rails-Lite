require 'byebug'
require 'uri'

def parse_key(key)
  key.split(/\]\[|\[|\]/)
end

key_string = "cat[name]"
key_2 = "user[address][street]=main&user[address][zip]=89436"

p parse_key(key_2)


def parse_www_encoded_form(www_encoded_form)
  params_array = URI::decode_www_form(www_encoded_form).map { |key, value| [parse_key(key), value] }
  params_hash = {}
  
  params_array.each do |param|
    current = params_hash
    keys = param[0]
    value = param[1]
    
    keys.each_with_index do |key, i|
      if i == (keys.length - 1)
        current[key] = value
      else
        current[key] ||= {}
        current = current[key]
      end
    end
  end

  params_hash
end


p parse_www_encoded_form(key_2)


# .flatten.map { |el| parse_key(el) }.flatten