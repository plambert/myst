require "./single_spec.mt"

defmodule Spec
  # AssertionFailure
  #
  # An AssertionFailure is a container object that is raised when an assertion
  # made within an `it` block fails. The failure contains the Spec object that
  # failed, the value that was expected, and the value that was received.
  deftype AssertionFailure
    def initialize(spec : SingleSpec, expected, got)
      @spec     = spec
      @expected = expected
      @got      = got
    end

    def spec;     @spec;      end
    def expected; @expected;  end
    def got;      @got;       end

    def to_s
      "Assertion failed: <(@spec.name)>.\n" +
      "    Expected: <(@expected)>\n" +
      "         Got: <(@got)>\n"
    end
  end
end
