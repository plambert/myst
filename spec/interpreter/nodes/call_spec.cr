require "../../spec_helper.cr"
require "../../support/nodes.cr"
require "../../support/interpret.cr"

# This section uses a small sample of Call formats to test the general ability
# of the interpreter to evaluate them. Coverage of infix operators, native
# functions, and standard library functions will be done separately.
#
# This section of tests relies on the Integer type with `+` and `to_s` methods
# defined.
describe "Interpreter - Call" do
  it_interprets %q(1 + 1),        [val(2)]
  it_interprets %q(1 + 1 + 1),    [val(3)]

  it_interprets %q(1.to_s),       [val("1")]
  it_interprets %q((1 + 1).to_s), [val("2")]

  # Functions in Modules
  it_interprets %q(
    module Foo
      def bar
        :called
      end
    end

    Foo.bar
  ),                [val(:called)]
  it_interprets %q(
    module Foo
      def bar(a, b)
        a + b
      end
    end

    Foo.bar(1, 2)
  ),                [val(3)]
  it_interprets %q(
    module Foo
      module Bar
        def baz
          :nested
        end
      end
    end

    Foo.Bar.baz
  ),                [val(:nested)]
end
