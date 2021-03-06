module Myst
  class Interpreter
    NativeLib.method :int_add, TInteger, other : Value do
      case other
      when TInteger
        TInteger.new(this.value + other.value)
      when TFloat
        TFloat.new(this.value + other.value)
      else
        __raise_runtime_error("invalid argument for Integer#+: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_subtract, TInteger, other : Value do
      case other
      when TInteger
        TInteger.new(this.value - other.value)
      when TFloat
        TFloat.new(this.value - other.value)
      else
        __raise_runtime_error("invalid argument for Integer#-: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_multiply, TInteger, other : Value do
      case other
      when TInteger
        TInteger.new(this.value * other.value)
      when TFloat
        TFloat.new(this.value * other.value)
      else
        __raise_runtime_error("invalid argument for Integer#*: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_divide, TInteger, other : Value do
      case other
      when TInteger
        __raise_runtime_error("Division by zero") if other.value == 0
        TInteger.new(this.value / other.value)
      when TFloat
        __raise_runtime_error("Division by zero") if other.value == 0
        TFloat.new(this.value / other.value)
      else
        __raise_runtime_error("invalid argument for Integer#/: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_modulo, TInteger, other : Value do
      case other
      when TInteger
        __raise_runtime_error("Division by zero") if other.value == 0
        TInteger.new(this.value % other.value)
      when TFloat
        __raise_runtime_error("Division by zero") if other.value == 0
        TFloat.new(this.value.to_f % other.value)
      else
        __raise_runtime_error("invalid argument for Integer#%: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_to_s, TInteger do
      TString.new(this.value.to_s)
    end

    NativeLib.method :int_eq, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value == other.value)
      else
        TBoolean.new(false)
      end
    end

    NativeLib.method :int_not_eq, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value != other.value)
      else
        TBoolean.new(true)
      end
    end

    NativeLib.method :int_negate, TInteger do
      TInteger.new(-this.value)
    end

    NativeLib.method :int_lt, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value < other.value)
      else
        __raise_runtime_error("invalid argument for Integer#<: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_lte, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value <= other.value)
      else
        __raise_runtime_error("invalid argument for Integer#<=: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_gt, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value > other.value)
      else
        __raise_runtime_error("invalid argument for Integer#>: #{__typeof(other).name}")
      end
    end

    NativeLib.method :int_gte, TInteger, other : Value do
      case other
      when TInteger, TFloat
        TBoolean.new(this.value >= other.value)
      else
        __raise_runtime_error("invalid argument for Integer#>=: #{__typeof(other).name}")
      end
    end

    def init_integer(kernel : TModule)
      integer_type = TType.new("Integer", kernel.scope)
      integer_type.instance_scope["type"] = integer_type

      NativeLib.def_instance_method(integer_type, :+,     :int_add)
      NativeLib.def_instance_method(integer_type, :-,     :int_subtract)
      NativeLib.def_instance_method(integer_type, :*,     :int_multiply)
      NativeLib.def_instance_method(integer_type, :/,     :int_divide)
      NativeLib.def_instance_method(integer_type, :%,     :int_modulo)
      NativeLib.def_instance_method(integer_type, :==,    :int_eq)
      NativeLib.def_instance_method(integer_type, :!=,    :int_not_eq)
      NativeLib.def_instance_method(integer_type, :to_s,  :int_to_s)
      NativeLib.def_instance_method(integer_type, :negate,:int_negate)
      NativeLib.def_instance_method(integer_type, :<,     :int_lt)
      NativeLib.def_instance_method(integer_type, :<=,    :int_lte)
      NativeLib.def_instance_method(integer_type, :>,     :int_gt)
      NativeLib.def_instance_method(integer_type, :>=,    :int_gte)

      integer_type
    end
  end
end
