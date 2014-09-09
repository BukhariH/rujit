#
# configuration file for specialized lir instruction
#
puts "// This file is auto generated by yarv2lir.rb"
puts "// DO NOT TOUCH!"
puts ""
puts "// If you want to fix something, you must edit 'yarv2lir.rb'"

DATA = [
  ["FixnumAddOverflow", "opt_plus",  "+", [:Fixnum, :Fixnum]],
  ["FixnumSubOverflow", "opt_minus", "-", [:Fixnum, :Fixnum]],
  ["FixnumMulOverflow", "opt_mult",  "*", [:Fixnum, :Fixnum]],
  ["FixnumDivOverflow", "opt_div",   "/", [:Fixnum, :Fixnum]],
  ["FixnumModOverflow", "opt_mod",   "%", [:Fixnum, :Fixnum]],

  ["FixnumEq", "opt_eq",  "==", [:Fixnum, :Fixnum]],
  ["FixnumNe", "opt_neq", "!=", [:Fixnum, :Fixnum]],
  ["FixnumGt", "opt_gt",  ">",  [:Fixnum, :Fixnum]],
  ["FixnumGe", "opt_ge",  ">=", [:Fixnum, :Fixnum]],
  ["FixnumLt", "opt_lt",  "<",  [:Fixnum, :Fixnum]],
  ["FixnumLe", "opt_le",  "<=", [:Fixnum, :Fixnum]],

  ["FixnumNeg", "opt_send_simple",           "-@", [:Fixnum]],
  ["FixnumPowOverflow", "opt_send_simple",   "**", [:Fixnum, :Fixnum]],
  ["FixnumPowOverflow", "opt_send_simple",   "**", [:Fixnum, :Bignum]],
  ["FixnumPowOverflow", "opt_send_simple",   "**", [:Fixnum, :Float]],
  ["FixnumAnd",        "opt_send_simple", "&", [:Fixnum, :Fixnum]],
  ["FixnumOr",         "opt_send_simple", "|", [:Fixnum, :Fixnum]],
  ["FixnumXor",        "opt_send_simple", "^", [:Fixnum, :Fixnum]],
  ["FixnumLshift",     "opt_send_simple", "<<",[:Fixnum, :Fixnum]],
  ["FixnumRshift",     "opt_send_simple", ">>",[:Fixnum, :Fixnum]],
  ["FixnumComplement", "opt_send_simple", "~", [:Fixnum]],
  ["FixnumSucc",       "opt_succ",        "succ", [:Fixnum]],

  ["FloatAdd", "opt_plus",  "+", [:Float, :Float]],
  ["FloatSub", "opt_minus", "-", [:Float, :Float]],
  ["FloatMul", "opt_mult",  "*", [:Float, :Float]],
  ["FloatDiv", "opt_div",   "/", [:Float, :Float]],
  ["FloatMod", "opt_mod",   "%", [:Float, :Float]],

  ["FloatEq", "opt_eq",  "==", [:Float, :Float]],
  ["FloatNe", "opt_neq", "!=", [:Float, :Float]],
  ["FloatGt", "opt_gt",  ">",  [:Float, :Float]],
  ["FloatGe", "opt_ge",  ">=", [:Float, :Float]],
  ["FloatLt", "opt_lt",  "<",  [:Float, :Float]],
  ["FloatLe", "opt_le",  "<=", [:Float, :Float]],

  ["FloatNeg", "opt_send_simple", "-@", [:Float]],
  ["FloatPow", "opt_send_simple", "**", [:Float, :Fixnum]],
  ["FloatPow", "opt_send_simple", "**", [:Float, :Float]],

  ["ObjectNot", "opt_not", "!",  [:_]],
  #["ObjectNe",  "opt_neq", "!=", [:_, :_]],
  #["ObjectEq",  "opt_eq",  "==", [:_, :_]],

  # converter
  # * => Fixnum
  #["FixnumToFixnum", "opt_send_simple", "to_i",   [:Fixnum]],
  ["FloatToFixnum",  "opt_send_simple", "to_i",   [:Float]],
  ["StringToFixnum", "opt_send_simple", "to_i",   [:String]],
  # * => Float
  ["FixnumToFloat", "opt_send_simple", "to_f",   [:Fixnum]],
  ["FloatToFloat",  "opt_send_simple", "to_f",   [:Float]],
  ["StringToFloat", "opt_send_simple", "to_f",   [:String]],
  # * => String
  ["FixnumToString", "opt_send_simple", "to_s",   [:Fixnum]],
  ["FloatToString",  "opt_send_simple", "to_s",   [:Float]],
  ["StringToString", "opt_send_simple", "to_s",   [:String]],

  # math API
  ["MathSin",   "opt_send_simple", "sin",   [:Math, :_]],
  ["MathCos",   "opt_send_simple", "cos",   [:Math, :_]],
  ["MathTan",   "opt_send_simple", "tan",   [:Math, :_]],
  ["MathExp",   "opt_send_simple", "exp",   [:Math, :_]],
  ["MathSqrt",  "opt_send_simple", "sqrt",  [:Math, :_]],
  ["MathLog10", "opt_send_simple", "log10", [:Math, :_]],
  ["MathLog2",  "opt_send_simple", "log2",  [:Math, :_]],

  ["StringLength", "opt_length",  "length", [:String]],
  ["StringLength", "opt_size",    "size",   [:String]],
  ["StringEmptyP", "opt_empty_p", "empty?", [:String]],
  ["StringConcat", "opt_plus",    "+",      [:String, :String]],
  ["StringConcat", "opt_ltlt",    "<<",     [:String, :String]],
  ["StringFreeze", "opt_str_freeze", "freeze", [:String]],

  ["ArrayLength", "opt_length",  "length", [:Array]],
  ["ArrayLength", "opt_size",    "size",   [:Array]],
  ["ArrayEmptyP", "opt_empty_p", "empty?", [:Array]],
  ["ArrayConcat", "opt_plus",    "+",      [:Array, :_]],
  ["ArrayConcat", "opt_ltlt",    "<<",     [:Array, :_]],
  ["ArrayGet",    "opt_aref|opt_aref_with", "[]",  [:Array, :Fixnum]],
  ["ArraySet",    "opt_aset|opt_aset_with", "[]=", [:Array, :Fixnum, :_]],

  ["HashLength", "opt_length",  "length", [:Hash]],
  ["HashLength", "opt_size",    "size",   [:Hash]],
  ["HashEmptyP", "opt_empty_p", "empty?", [:Hash]],
  ["HashGet",    "opt_aref|opt_aref_with", "[]",  [:Hash, :_]],
  ["HashSet",    "opt_aset|opt_aset_with", "[]=", [:Hash, :_, :_]],

  ["RegExpMatch", "opt_regexpmatch1|opt_regexpmatch2", "=~", [:String, :Regexp]],

  ["ObjectToString", "tostring", "", [:String]],
  ["TimeSucc",    "opt_succ", "succ", [:Time]],

  ["GetPropertyName", "opt_send_simple", "#getter", [:Object]],
  ["SetPropertyName", "opt_send_simple", "#setter", [:Object, :_]]
];

class Rule
  attr_accessor :type, :val, :need_guard

  def initialize(type, val, guard = :default)
    @type = type
    @val  = val
    @need_guard = guard
  end

  def emit_guard
  end
end

class Opcode < Rule
  def initialize(val)
    super("", val)
  end
  def to_s
    @val.split("|").map {|v|
      "opcode == BIN(#{v})"
    }.join(" || ")
  end
end

class Mtype < Rule
  def initialize(val, guard)
    super("", val, guard)
  end
  def symbolize(sym)
    return "VM_METHOD_TYPE_IVAR"    if sym == "#getter";
    return "VM_METHOD_TYPE_ATTRSET" if sym == "#setter";
    return sym
  end

  def to_s
    "ci->me && ci->me->def->type == #{symbolize(@val)}"
  end

  def emit_guard
    "Emit_GuardMethodCache(Rec, pc, regs[0], ci)"
  end
end

class Mid < Rule
  def initialize(val)
    super("", val)
  end
  def symbolize(sym)
    return "idPLUS"      if sym == '+'
    return "idMINUS"     if sym == '-'
    return "idMULT"      if sym == '*'
    return "idDIV"       if sym == '/'
    return "idMOD"       if sym == '%'
    return "idPow"       if sym == '**'
    return "idLT"        if sym == '<'
    return "idLTLT"      if sym == '<<'
    return "idLE"        if sym == '<='
    return "idGT"        if sym == '>'
    return "idGE"        if sym == '>='
    return "idEq"        if sym == '=='
    return "idNeq"       if sym == '!='
    return "idNot"       if sym == '!'
    return "idNot"       if sym == "not";
    return "idAREF"      if sym == "[]"
    return "idASET"      if sym == "[]="
    return "idLength"    if sym == "length"
    return "idSize"      if sym == "size"
    return "idEmptyP"    if sym == "empty?"
    return "idSucc"      if sym == "succ"
    return "idEqTilde"   if sym == "=~"
    return "rb_intern(\"#{sym}\")"
  end

  def to_s
    "ci->mid == #{symbolize(@val)}"
  end
end

class Argc < Rule
  def initialize(val)
    super("", val)
  end
  def to_s
    "ci->argc == #{@val - 1}"
  end
end

class Unredefined < Rule
  def initialize(bop, type, guard)
    super(bop, type, guard)
  end

  def symbolize(sym)
    return "JIT_BOP_PLUS"      if sym == '+'
    return "JIT_BOP_MINUS"     if sym == '-'
    return "JIT_BOP_MULT"      if sym == '*'
    return "JIT_BOP_DIV"       if sym == '/'
    return "JIT_BOP_MOD"       if sym == '%'
    return "JIT_BOP_POW"       if sym == '**'
    return "JIT_BOP_LT"        if sym == '<'
    return "JIT_BOP_LTLT"      if sym == '<<'
    return "JIT_BOP_LE"        if sym == '<='
    return "JIT_BOP_GT"        if sym == '>'
    return "JIT_BOP_GE"        if sym == '>='
    return "JIT_BOP_EQ"        if sym == '=='
    return "JIT_BOP_NEQ"       if sym == '!='
    return "JIT_BOP_NOT"       if sym == '!'
    return "JIT_BOP_NOT"       if sym == "not";
    return "JIT_BOP_AREF"      if sym == "[]"
    return "JIT_BOP_ASET"      if sym == "[]="
    return "JIT_BOP_LENGTH"    if sym == "length"
    return "JIT_BOP_SIZE"      if sym == "size"
    return "JIT_BOP_EMPTY_P"   if sym == "empty?"
    return "JIT_BOP_SUCC"      if sym == "succ"
    return "JIT_BOP_MATCH"     if sym == "=~"
    return "JIT_BOP_FREEZE"    if sym == "freeze"

    return "JIT_BOP_NEG"       if sym == '-@'
    return "JIT_BOP_AND"       if sym == '&'
    return "JIT_BOP_OR"        if sym == '|'
    return "JIT_BOP_XOR"       if sym == '^'
    return "JIT_BOP_INV"       if sym == '~'
    return "JIT_BOP_RSHIFT"    if sym == '>>'

    return "JIT_BOP_TO_F"    if sym == 'to_f'
    return "JIT_BOP_TO_I"    if sym == 'to_i'
    return "JIT_BOP_TO_S"    if sym == 'to_s'
    # math
    return "JIT_BOP_SIN"       if sym == 'sin'
    return "JIT_BOP_COS"       if sym == 'cos'
    return "JIT_BOP_TAN"       if sym == 'tan'
    return "JIT_BOP_EXPR"      if sym == 'expr'
    return "JIT_BOP_SQRT"      if sym == 'sqrt'
    return "JIT_BOP_LOG2"      if sym == 'log2'
    return "JIT_BOP_LOG10"     if sym == 'log10'
    return "JIT_BOP_" + sym.upcase
  end

  def redefinition_flag(klass)
    return klass.to_s.upcase + "_REDEFINED_OP_FLAG"
  end

  def to_s
    "JIT_OP_UNREDEFINED_P(#{symbolize @val}, #{redefinition_flag @type})"
  end
  def emit_guard
    s  = "Emit_GuardMethodRedefine(Rec, pc, "
    s += "#{redefinition_flag @type}, #{symbolize @val})"
  end
end

class Type < Rule
  def initialize(val, type, guard)
    super(type, val, guard)
  end

  def to_s
    p = "params[#{@val}]"
    if @type == :Fixnum
      return "FIXNUM_P(#{p})"
    elsif @type == :Float
      s  = "RB_FLOAT_TYPE_P(#{p})"
      return s;
    elsif @type == :Object
      return "RB_TYPE_P(#{p}, T_OBJECT)"
    elsif @type == :_
      return "1/*typeof #{p} is Any*/"
    else
      return "!SPECIAL_CONST_P(#{p}) && RBASIC_CLASS(#{p}) == rb_c#{@type}"
    end
  end
  def emit_guard
    p = "regs[#{@val}]"
    if @type == :Fixnum
      return "Emit_GuardTypeFixnum(Rec, pc, #{p})"
    elsif @type == :Float
      s = "Emit_GuardTypeFloat(Rec, pc, #{p});"
    elsif @type == :_
      return ""
    else
      s  = "Emit_GuardTypeSpecialConst(Rec, pc, #{p}); "
      s += "Emit_GuardType#{@type}(Rec, pc, #{p})"
      return s
    end
  end

end

def indent(i)
  i.times { print "  " }
end

def op(idx, name, arg, emit_lir)
  i = 0
  puts "if ( // rule#{idx} #{name}"
  puts arg.map {|a|
    "  (#{a.to_s})"
  }.join(" &&\n")
  puts ") {"
  if emit_lir
    arg.select {|r|
      r.need_guard == :guard
    }.each {|r|
      s = r.emit_guard
      if !s.empty?
        indent(i + 1);
        puts s + ";"
      end
    }
  end
  indent(i + 1);
  if emit_lir
    puts "return EmitSpecialInst_#{name}(Rec, ci, regs);"
  else
    puts "return 1;"
  end
  indent(i)
  puts "}"
end

def opcode(name)
  Opcode.new(name)
end

def mtype(mname, guard = :default)
  Mtype.new(mname, guard)
end

def mid(mname)
  Mid.new(mname)
end

def argc(argc)
  Argc.new(argc)
end

def unredefined(bop, type, guard = :default)
  Unredefined.new(bop, type, guard)
end

def type(idx, type, guard = :default)
  Type.new(idx, type, guard)
end

def emit_main
  max_param_size = 0

  DATA.each { |op|
    arg    = op[3]
    if arg.length > max_param_size
      max_param_size = arg.length
    end
  }

  puts "static lir_t EmitSpecialInst(trace_recorder_t *Rec, VALUE *pc, CALL_INFO ci,"
  puts "enum ruby_vminsn_type opcode, VALUE *params,"
  puts "lir_t *regs)"
  puts "{"

  DATA.each.with_index { |op, i|
    opname = op[0]
    yarvop = op[1]
    mname  = op[2]
    arg    = op[3]
    param = []
    param << opcode(yarvop)
    if mname == "#getter" || mname == "#setter"
      param << mtype(mname, :guard)
    elsif !mname.empty?
      param << mid(mname)
    end

    param << argc(arg.length)
    if !mname.empty? && mname != "#getter" && mname != "#setter"
      if arg.length > 0 && arg[0].to_sym != :_
        param << unredefined(arg[0].to_sym, mname, :guard)
      end
    end

    arg.map.with_index { |v, i|
      if arg[i] != :_
        param << type(i, v, :guard)
      else
        param << type(i, v)
      end
    }
    op(i, opname, param, true)
  }
  puts "    return NULL;"
  puts "}"
end

def emit_check_tracable_method
  max_param_size = 0

  DATA.each { |op|
    arg    = op[3]
    if arg.length > max_param_size
      max_param_size = arg.length
    end
  }

  puts "static int is_tracable_special_inst(int opcode, CALL_INFO ci)"
  puts "{"

  DATA.each.with_index { |op, i|
    opname = op[0]
    yarvop = op[1]
    mname  = op[2]
    arg    = op[3]
    param = []
    param << opcode(yarvop)
    if yarvop == "opt_send_simple" || yarvop == "opt_send"
      param << argc(arg.length)
      if mname == "#getter" || mname == "#setter"
        param << mtype(mname, :guard)
      elsif !mname.empty?
        param << mid(mname)
      end
      if !mname.empty? && mname != "#getter" && mname != "#setter"
        if arg.length > 0 && arg[0].to_sym != :_
          param << unredefined(arg[0].to_sym, mname, :guard)
        end
      end

      op(i, opname, param, false)
    end
  }
  puts "    return 0;"
  puts "}"
end


emit_main
emit_check_tracable_method
