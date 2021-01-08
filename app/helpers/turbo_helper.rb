# frozen_string_literal: true

module TurboHelper
  def render(component, *args)
    turbo_id = component.try(:turbo_id)

    super unless turbo_id

    parent_turbo_component = params[:parent_turbo_component]

    if !parent_turbo_component || parent_turbo_component == turbo_id
      super(component, *args)
    end
  end
end
