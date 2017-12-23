require "stdlib/spec.mt"

Spec.initialize
include Spec.DSL


# TODO: add Dir globbing to automatically detect and require all `*_spec.mt`
# files under this directory.
require "./enumerable_spec.mt"
require "./integer_spec.mt"
require "./list_spec.mt"
require "./map_spec.mt"
require "./string_spec.mt"
require "./unary_ops/not_spec.mt"
require "./type_spec.mt"
require "./time_spec.mt"


when :ok == Spec.run
  IO.puts("\nAll specs passed.")
else
  IO.puts("\nNot all specs passed.")
  exit(1)
end
