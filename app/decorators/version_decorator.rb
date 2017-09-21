class VersionDecorator < Draper::Decorator
  delegate_all
  
  def to_json
    {
      'ios': {
        'minimal_recomended': ios_minimal_recomended,
        'minimal_compatible': ios_minimal_compatible,
        'blocked': ios_blocked
      },
      'android': {
        'minimal_recomended': android_minimal_recomended,
        'minimal_compatible': android_minimal_compatible,
        'blocked': android_blocked
      }
    }.to_json
  end
end
