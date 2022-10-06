require 'awesome_print'
require 'terminal-table'
require 'colorize'
require 'tty-prompt'
require 'tty-spinner'
require 'pastel'

system("clear")
def banner
  puts "...oo0o0:: Rejka Industries ::0o0oo...\n".yellow.bold
  puts "     SUBNETMASK CALCULATOR CLASS C    \n".yellow.bold
end

def menu
  puts "[1] MBTL (More Better Than Less!)".bold
  puts "[2] Ip and Subnet\n".bold
end

class Main
  attr_accessor :running, :userInput,
  :subnet,:max_num,:z_num,:index,:res,
  :ip_field, :ip, :prompt
  def initialize
    @running               = true
    @userInput             = false
    @prompt                = TTY::Prompt.new
    @ip                    = @prompt.ask("IP\t\t:".yellow.bold)
    @subnet                = @prompt.ask("SUBNET\t\t:".yellow.bold)
    @max_num               = 32
    @z_num                 = @max_num - @subnet.to_i
    @index                 = 8 - @z_num
    @res                   = "1"*(@index)+"0"*@z_num
    @ip_field              = {}
    @ip_field[:net_id]     = []
    @ip_field[:ip_range]   = []
  end
end

if __FILE__ == $0
  banner
  menu
  main = Main.new
  num = 1
  arr = [];8.times do |i|
    arr << num
    num += num
  end

  arr.reverse!
  num_step              = arr[main.index-1]
  
  256.times do |i|
    if (i % num_step == 0)
      def ct(ip, num_s)
        ip.gsub(/\d+$/,num_s)
      end

      def db_ct(f,s)
        "#{ct(f[0],f[1])} - #{ct(s[0],s[1])}"
      end

      main.ip_field[:net_id]       << ct(main.ip, i.to_s)
      res = "#{db_ct([main.ip,(i+1).to_s], [main.ip,(i+num_step-1).to_s])}"
      main.ip_field[:ip_range]     << res
    end
  end
  main.ip_field[:all] = Hash[main.ip_field[:net_id].zip(main.ip_field[:ip_range])]

  table_all = Terminal::Table.new :headings => ["Net Id", "Ip Range"] do |t|
    main.ip_field[:all].each do |i|
      t << i
    end
  end

  main.ip_field[:net_id].each_with_index {|k,v| puts "#{v+1}.#{k}" }
end