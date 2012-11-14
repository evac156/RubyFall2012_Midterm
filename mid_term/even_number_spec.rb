require "#{File.dirname(__FILE__)}/evenNumber"

describe EvenNumber do

  it "takes a positive even number and returns an EvenNumber object" do
    en1 = EvenNumber.new(12)
    en1.value.should == 12
  end

  it "takes a zero and returns an EvenNumber object" do
    en2 = EvenNumber.new(0)
    en2.value.should == 0
  end

  it "takes a negative even number and returns an EvenNumber object" do
    en3 = EvenNumber.new(-4)
    en3.value.should == (-4)
  end

  it "rejects odd integers" do
    arg = 3
    msg = argErrFmt(arg)
    expect { en = EvenNumber.new(arg) }.to raise_error(ArgumentError, msg)
  end

  it "rejects Floats" do
    arg = 2.712
    msg = argErrFmt(arg)
    expect { en = EvenNumber.new(arg) }.to raise_error(ArgumentError, msg)
  end

  it "rejects Strings" do
    arg = "fish"
    msg = argErrFmt(arg)
    expect { en = EvenNumber.new(arg) }.to raise_error(ArgumentError, msg)
  end

  it "rejects nil" do
    arg = nil
    msg = argErrFmt(arg)
    expect { en = EvenNumber.new(arg) }.to raise_error(ArgumentError, msg)
  end

  def argErrFmt(p)
    "EvenNumber received #{p.inspect}; argument must be an even Integer"
  end

  it "returns the next even number" do
    en1 = EvenNumber.new(-28)
    en1a = en1.succ
    en1a.value.should == (-26)

    en2 = EvenNumber.new(0)
    en2a = en2.succ.succ.succ
    en2a.value.should == 6

    en3 = EvenNumber.new(1000)
    40.times do
      en3 = en3.succ
    end
    en3.value.should == (1080)
  end

  it "returns the previous even number" do
    en1 = EvenNumber.new(16878)
    en1a = en1.prev
    en1a.value.should == (16876)

    en2 = EvenNumber.new(6)
    en2a = en2.prev.prev.prev.prev.prev.prev
    en2a.value.should == (-6)

    en3 = EvenNumber.new (-18)
    77.times do
      en3 = en3.prev
    end
    en3.value.should == (-172)
  end

  it "allows mixing of next and previous methods" do
    en1 = EvenNumber.new(144)
    en1a = en1.succ.succ.prev.prev.succ.succ.succ
    en1a.value.should == 150

    en2 = EvenNumber.new (-7776)
    en2a = en2.succ.succ.succ.succ.prev.succ.succ
    en2a.value.should == (-7766)

    en3 = EvenNumber.new (92760)
    35.times do
      en3 = en3.succ.succ.prev.succ.succ
    end
    en3.value.should == 92970
  end

  it "compares two EvenNumber values" do
    en1 = EvenNumber.new(16)
    en2 = EvenNumber.new(0)
    en3 = EvenNumber.new(-22)
    en4 = EvenNumber.new(16)

    (en1 <=> en1).should == 0
    (en1 != en1).should be_false
    (en1 <=> en2).should == 1
    (en1 > en2).should be_true
    (en1 <=> en3).should == 1
    (en1 > en3).should be_true
    (en1 <=> en4).should == 0
    (en1 == en4).should be_true

    (en2 <=> en1).should == (-1)
    (en2 < en1).should be_true
    (en2 <=> en2).should == 0
    (en2 != en2).should be_false
    (en2 <=> en3).should == 1
    (en2 > en3).should be_true
    (en2 <=> en4).should == (-1)
    (en2 < en4).should be_true

    (en3 <=> en1).should == (-1)
    (en3 < en1).should be_true
    (en3 <=> en2).should == (-1)
    (en3 < en2).should be_true
    (en3 <=> en3).should == 0
    (en3 != en3).should be_false
    (en3 <=> en4).should == (-1)
    (en3 < en4).should be_true

    (en4 <=> en1).should == 0
    (en4 == en1).should be_true
    (en4 <=> en2).should == 1
    (en4 > en2).should be_true
    (en4 <=> en3).should == 1
    (en4 > en3).should be_true
    (en4 <=> en4).should == 0
    (en4 != en4).should be_false
  end

  it "produces a range of even numbers from -12 to 24" do
    en1 = EvenNumber.new(-12)
    en2 = EvenNumber.new(24)
    r1 = (en1..en2)

    r1.count.should == 19
    r1.min.value.should == (-12)
    r1.max.value.should == (24)
    # Because we've defined the == operator, can use include? instead of cover?
    r1.include?(EvenNumber.new(18)).should be_true
    r1.include?(EvenNumber.new(-4)).should be_true
    r1.include?(EvenNumber.new(36)).should be_false
    r1.include?(EvenNumber.new(-14)).should be_false
  end

  it "produces a range of even numbers from 38 to 46" do
    target = "[38, 40, 42, 44, 46]"
    en1 = EvenNumber.new(38)
    en2 = EvenNumber.new(46)
    r1 = (en1..en2)

    r1.count.should == 5
    r1.min.value.should == (38)
    r1.max.value.should == (46)
    r1.include?(EvenNumber.new(28)).should be_false
    r1.include?(EvenNumber.new(48)).should be_false
    r1.include?(EvenNumber.new(38)).should be_true
    r1.include?(EvenNumber.new(44)).should be_true

    accumulator = "["
    r1.inject(accumulator) do |soFar, nextVal|
      soFar << (nextVal.to_s + (if (nextVal != r1.last) then ", " else "]" end))
    end
    accumulator.should == target
  end
end

