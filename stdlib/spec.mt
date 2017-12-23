require "./spec/dsl.mt"
require "./spec/errors.mt"
require "./spec/single_spec.mt"

# Spec
#
# A simple library for writing specs around Myst code. Specs are written using
# `it`, providing either a name, a code block to test, or both. Multiple `it`s
# can be organized under a `describe` block for better visual clarity.
#
# The Spec library operates primarily through `assert`. Each spec can make
# multiple calls to `assert`, with an argument that is expected to be truthy.
# If the given argument is not truthy, the spec is considered failed, and the
# suite will not pass.
#
# By default, a passing assertion will output a green `.` to the terminal,
# while a failing assertion will output a red `F`. For now, execution will
# immediately halt on the first assertion failure, and the program will exit
# with a non-zero status code.
defmodule Spec
  include DSL

  def initialize
    @specs ||= []
  end

  def add_spec(spec : SingleSpec)
    @specs += [spec]
  end

  def run
    IO.puts("Found <(@specs.size)> specs. Starting run:\n\n")

    # Run all the specs, capturing all of the failures into an array
    failures = []
    @specs.each do |spec|
      when result = spec.run
        IO.print(".")
      else
        failures += [spec]
        IO.print("F")
      end
    end
    IO.puts("\n")

    # Output the details of each failure at the end.
    when failures.empty?
      return :ok
    end

    IO.puts("\n\nFailures:\n")

    failure_index = 0
    failures.each do |spec|
      failure_index += 1
      IO.puts
      IO.puts("<(failure_index)>) <(spec.name)>")
      IO.puts(spec.result)
    end

    return [:failed, failures]
  end
end
