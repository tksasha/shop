Rails.application.configure do
  config.active_record.observers = :order_observer
end
