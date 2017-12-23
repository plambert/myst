defmodule Spec
  deftype SingleSpec
    def initialize(name : String, &body)
      @name = name
      @container = nil
      @body = &body
      @passed = nil
      @failure = nil
    end

    def name; @name; end
    def passed?; @passed; end
    def result; @result; end
    def body; @body; end

    def run
      # The syntax doesn't currently support chained parentheses or parentheses
      # on ivars, so the body functor must be pushed into a local, then called.
      block = @body
      @result = block()
      @passed = true
    rescue failure
      @result = failure
      @passed = false
    end



    def assert(assertion)
      unless assertion
        raise %AssertionFailure{self, true, assertion}
      end
    end

    def refute(assertion)
      when assertion
        raise %AssertionFailure{self, false, assertion}
      end
    end

    # Expect the given block to raise an error matching the given value. If no
    # error, or an error with a different value, is raised, the assertion fails.
    def expect_raises(expected_error, &block)
      block()
      raise %AssertionFailure{self, expected_error, "no error"}
    rescue <expected_error>
      # If the raised error matches what was expected, the assertion passes.
    rescue received_error
      # For any other error
      raise %AssertionFailure{self, expected_error, received_error}
    end

    # Same as `expect_raises(expected, &block)`, but without the expectation of
    # a specific error.
    def expect_raises(&block)
      block()
      raise %AssertionFailure{self, expected_error, "no error"}
    rescue
      # If an error was raised, the assertion passes.
    end
  end
end
