class ApplicationDecorator < Draper::Decorator
  def operation_date
    object.created_at.strftime "%d/%m/%Y à %H : %M : %S"
  end
end
