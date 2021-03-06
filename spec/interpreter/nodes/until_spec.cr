require "../../spec_helper.cr"
require "../../support/nodes.cr"
require "../../support/interpret.cr"

describe "Interpreter - Until" do
  it_interprets %q(
    a = 1
    until a == 1
      a = 2
      "ran"
    end
  ),                  [val(nil)]
  it_interprets %q(
    a = 1
    until a != 1
      "ran"
    end
  ),                  [val(nil)]
  it_interprets %q(
    a = 1
    until a != 1; end
  ),                  [val(nil)]
end
