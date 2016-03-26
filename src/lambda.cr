require "./lambda/*"

macro lambda_method(method)
  {% if method.args.size == 0 %}
    raise "Uniformed functions have to have at least one parameter."
  {% end %}

  {% args = method.args.argify %}

  {% if method.args.size > 1 %}
    {% args = args.gsub(/^.+?, /, "") %}
  {% else %}
    {% args = "" %}
  {% end %}

  # Define original method
  {{method.id}}

  class Object
    def {{method.name.id}}({{args.id}})
      {{method.args.first.name}} = self
      {{method.body}}
    end
  end
end

macro lambda_block(name, &block)
  {% if block.args.size == 0 %}
    raise "Uniformed functions have to have at least one parameter."
  {% end %}

  {% args = block.args.join(", ").gsub(/_as_/, " : ") %}

  {% if block.args.size > 1 %}
    {% args = args.gsub(/^[^\,]*\,/, "") %}
  {% else %}
    {% args = "" %}
  {% end %}

  class Object
    def {{name.id}}({{args.id}})
      {{block.args.first.id.split("_as_")[0].id}} = self
      {{block.body}}
    end
  end
  def {{name.id}}({{block.args.first.id.gsub(/_as_/, " : ")}},{{args.id}})
    {{block.body}}
  end
end

macro λ(name, &block)
  {% if name.is_a?(Def) %}
    lambda_method {{name}}
  {% else %}
    lambda_block {{name}} {{block}}
  {% end %}
end

macro lambda(name, &block)
  λ {{name}} {{block}}
end
