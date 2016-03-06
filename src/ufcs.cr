require "./ufcs/*"

macro ufcs(t, cls, name, &block)
  {{args = block.args.join(",")}}
  {{t.id}} {{cls}}
      def {{name}}({{args.id}})
      this = self
      {{block.body}}
    end
  {{"end".id}}
  def {{name}}(this, {{args.id}})
    {{block.body}}
  end
end

macro udef_class(name, cls, &block)
  {{args = block.args.join(",")}}
  ufcs "class", {{cls}}, {{name}} do {% if block.args.size > 0 %}|{{args.id}}|{% end %}
    {{block.body}}
  end
end

macro udef_struct(name, cls, &block)
  {{args = block.args.join(",")}}
  ufcs "struct", {{cls}}, {{name}} do {% if block.args.size > 0 %}|{{args.id}}|{% end %}
    {{block.body}}
  end
end

