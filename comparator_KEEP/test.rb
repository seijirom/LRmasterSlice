def each_element file
  sym=x=y=rot=name=l=w=m=nil
  File.read(file).each_line{|l|
    l.chomp!
    if l =~ /SYMBOL (\S+) (\S+) (\S+) (\S+)/
      sym = $1
      x = $2
      y = $3
      rot=$4
    elsif l =~ /SYMATTR InstName (\S+)/
      name = $1
    elsif l =~ /SYMATTR|Value2 SpiceLine l=(\S+)u w=(\S+)u .* m=(\S+)/ ||
          l =~ /SYMATTR|Value2 SpiceLine l=(\S+)u w=(\S+)u/
      l=$1
      w=$2
      m=$3
      yield sym, name, l, w, m ? m : 1, x, y, rot
    end
  }
end

each_element('COMP_NLF.asc'){|sym, name, l, w, m, x, y, rot|
  puts "#{sym}/#{name}: l=#{l} w=#{w} m=#{m ? m : 1} @ (#{x}, #{y}), #{rot}"
}
