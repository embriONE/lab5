class CashMachine
    def initialize
      @balance = 100
      @stateMenu = '0'
      @bank_account = 'balance.txt'
    end
  
    def bankAccount()
      if File.exist?(@bank_account)
        File.foreach(@bank_account) { |string| @balance = string.to_i }
      else puts 'File not found'
      end
      puts "Your balance: #{@balance}"
    end
  
    def menu
      puts "choose act: (0) Exit the programm (1) Deposit (2) Withdraw (3) balance: "
      @stateMenu = gets.chomp
    end
  
    def init
      menu
      while (@stateMenu != '0') 
        case @stateMenu
        when '1'
          deposit
          menu
        when '2'
          withdraw
          menu
        when '3'
          balance
          menu
        else
          puts 'wrong number'
        end
      end
    end
  
    def deposit
      puts 'type amount to dep:'
      depositSum = gets.to_i
      if depositSum > 0
        @balance += depositSum
      else puts 'wrong number'
      end
      puts "balance now is: #{@balance}"
    end
  
    def withdraw
      puts 'type amount to withdraw:'
      withdrawSum = gets.to_i
      if (withdrawSum > 0) && (withdrawSum <= @balance)
        @balance -= withdrawSum
      else puts 'wrong number'
      end
      puts "balance now is: #{@balance}"
    end
  
    def balance
      puts "balance now is: #{@balance}"
    end
  end
  
  bankAccount = CashMachine.new()
  bankAccount.bankAccount()
  bankAccount.init