defmodule Spec

  defmodule DSL
    def it(name, &test_body)
      Spec.add_spec(%SingleSpec{"<(@spec_prefix)> <(name)>", &test_body})
    end

    def it(&test_body)
      Spec.add_spec(%SingleSpec{@spec_prefix, &test_body})
    end

    def it(name)
      Spec.add_spec(%SingleSpec{@spec_prefix}{})
    end


    def describe(name, &body)
      @spec_prefix ||= ""
      old_name = @spec_prefix
      @spec_prefix += "<(name)> "

      body()

      @spec_prefix = old_name
    end
  end
end
