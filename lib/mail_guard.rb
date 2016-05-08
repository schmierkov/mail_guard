class MailGuard
  def initialize(recipients: [],
                 permitted_hosts: [],
                 default_recipient: nil,
                 subject_prefix: nil)
    @recipients        = recipients
    @permitted_hosts   = permitted_hosts
    @default_recipient = default_recipient
    @subject_prefix    = subject_prefix
  end

  def delivering_email(message)
    if @recipients.any?
      message.to = @recipients
    elsif @permitted_hosts.any?
      permitted_recipients = []

      message.to.each do |recipient|
        permitted_recipients << recipient if permitted?(recipient)
      end

      if permitted_recipients.any?
        message.to = permitted_recipients
      else
        message.to = fallback_recipients
      end
    else
      message.to = fallback_recipients
    end

    message.subject = "#{subject_prefix_text}#{message.subject}"
  end

  private

  def subject_prefix_text
    if @subject_prefix
      if @subject_prefix.is_a?(String)
        "#{@subject_prefix} "
      else
        "[#{Rails.env.upcase}] "
      end
    end
  end

  def fallback_recipients
    @default_recipient || ["default@example.com"]
  end

  def permitted?(recipient)
    @permitted_hosts.each do |permitted_host|
      return true if recipient.ends_with?(permitted_host)
    end
    false
  end
end
