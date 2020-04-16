class Transfer
  attr_reader :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if (sender.balance < amount || receiver.status == 'closed')
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    if @status == 'pending'
      if sender.balance < amount
        return "Transaction rejected. Please check your account balance"
      else
        sender.balance -= amount
        receiver.balance += amount
        @status = 'complete'
      end
    end
  end

  def reverse_transfer
    if status == 'complete'
      receiver.balance -= amount
      sender.balance += amount
      @status = 'reversed'
    end
  end
 
end
