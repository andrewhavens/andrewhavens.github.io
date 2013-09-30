---
title: Creating a Rails nested attributes forms for polymorphic/single table inheritance associations
---
```ruby
- actions = Promotion::Action.available_actions
- action_params = params.fetch(:promotion, {}).fetch(:action_attributes, nil)
- if @promotion.action && action_params.nil?
  - action_model = @promotion.action
- elsif action_params
  - action_model = @promotion.build_action(action_params)
- else
  - action_model = @promotion.build_action

.row
  = f.fields_for :action, action_model do |action_form|
    .span4= action_form.input_field :_type, collection: actions.map{|a|[a.description, a]}, style: 'width:100%'

  -# Display a hidden form for each action type, populating with the previous values or param values depending on state
  - actions.each do |action_class|

    - if @promotion.action.class == action_class && action_params.nil?
      - action_model = @promotion.action
    - elsif action_params && action_class.to_s == action_params.fetch(:_type)
      - action_model = action_class.new(action_params)
    - else
      - action_model = action_class.new

    = f.fields_for :action, action_model do |action_form|
      .action_fields.span5{data: {fields_for: action_class}}
        = render partial: "admin/promotions/actions/#{action_class.action_type}", locals: {f: action_form}
```

```ruby
:coffeescript
  Rejuvenation.Admin.Data.PromotionConditions = #{@promotion.conditions.to_json}

- conditions = Promotion::Condition.available_conditions

#promotion_conditions
  / will go here

%script.promotion_condition_row_template{type: 'text/html'}
  .row
    = f.fields_for :conditions, @promotion.conditions.build do |conditions_form|
      .span4
        = conditions_form.input_field :_type, collection: conditions.map{|a|[a.description, a]}, class: 'condition_type input-xlarge'
      .condition_fields.span4
        / dependent fields will go here
      .span1= remove_button

-# Blank form fields for copying
- conditions.each do |condition_class|
  %script{type: 'text/html', data: {fields_for: condition_class}}
    = f.fields_for :conditions, condition_class.new do |condition_form|
      = render partial: "admin/promotions/conditions/#{condition_class.condition_type}", locals: {f: condition_form}

.row
  .span9
    = add_button 'Add a Condition', id: 'add_promotion_condition'
```

```coffeescript
# Promotion Conditions fields

  $('#add_promotion_condition').click (e)->
    e.preventDefault()
    row_html = $('.promotion_condition_row_template').html()
    row = $(row_html)
    id = $('#promotion_conditions .row').length
    row.data 'base_name', "promotion[conditions_attributes][#{id}]"
    if id > 0 then row.find('.condition_type').before $('#promotion_conditions_combination_operator').clone()
    row.find(':input').each (i, el)->
      new_name = $(el).attr('name').replace(/\d/, id)
      $(el).attr('name', new_name)
    row.appendTo('#promotion_conditions').show()
    promo_form.trigger(Rejuvenation.Admin.Promotion.Event.CONDITION_ADDED, [row])




  $('#promotion_conditions').on 'change', '.condition_type', ->
    type = $(@).find('option:selected').val()
    new_fields_html = $('[data-fields_for="' + type + '"]').html()
    new_fields = $(new_fields_html)
    new_fields.filter(':input').each (i, el)->
      count = $('#promotion_conditions .row').length - 1
      new_name = $(el).attr('name').replace(/\d/, count)
      $(el).attr('name', new_name)
    row = $(@).closest('.row')
    row.find('.condition_fields').html(new_fields)
    promo_form.trigger(Rejuvenation.Admin.Promotion.Event.CONDITION_TYPE_CHANGE, [row] )


  $('#promotion_conditions').on 'change', '[name="promotion[conditions_combination_operator]"]', ->
    selected_val = $(@).find('option:selected').val()
    $('[name="promotion[conditions_combination_operator]"]').val(selected_val)

  $('#promotion_conditions').on 'click', '.remove', (e)->
    e.preventDefault()
    row = $(@).closest('.row')
    row.append "<input type='hidden' name='#{row.data('base_name')}[_destroy]' value='1'>"
    row.hide()
    $('#promotion_conditions .row').filter(':visible').first().find('#promotion_conditions_combination_operator').remove()
    promo_form.trigger(Rejuvenation.Admin.Promotion.Event.CONDITION_REMOVED)

  # Display Conditions that have been previously created
  if conditions = Rejuvenation.Admin.Data.PromotionConditions
    for condition in conditions
      $('#add_promotion_condition').trigger('click')
      row = $('#promotion_conditions .row').last()
      row.append "<input type='hidden' name='#{row.data('base_name')}[_id]' value='#{condition._id}'>"
      row.find('.condition_type').val(condition._type).trigger('change')
      row.find('.condition_fields :input').each (i, field)->
        field_name = /promotion\[conditions_attributes\]\[\d+\]\[(.*)\]/.exec($(field).attr('name'))[1]
        $(field).val(condition[field_name]).trigger('change')

  # Promotion Action fields

  $('#promotion_action_attributes__type').change ->
    type = $(@).find('option:selected').val()
    # $('#action_fields').html $('[data-fields_for="' + type + '"]').html()
    $('.action_fields').hide().find(':input').attr('disabled', true)
    $('[data-fields_for="' + type + '"]').show().find(':input').attr('disabled', false)

  $('#promotion_action_attributes__type').trigger 'change'
```