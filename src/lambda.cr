require "./lambda/*"

macro λ(name, &block)
  {% if block.args.size == 0 %}
    raise "Uniformed functions have to have at least one parameter."
  {% end %}
  {{args = block.args.join(",")}}
  {% if block.args.size > 1 %}
    {{args = args.gsub(/^[^\,]\,/, "")}}
  {% else %}
    {{args = ""}}
  {% end %}
  class Object
    def {{name.id}}({{args.id}})
      {{block.args.first.id}} = self
      {{block.body}}
    end
  end
  def {{name.id}}({{block.args.first.id}},{{args.id}})
    {{block.body}}
  end
end

macro lambda(name, &block)
  λ {{name}} {{block}}
end
