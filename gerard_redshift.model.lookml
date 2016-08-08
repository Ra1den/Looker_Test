- connection: red_look

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}

- explore: orders

- explore: users

- explore: order_items
#  view_label: 'Test'
#  always_filter:
#    orders.status: 'complete'
#  sql_always_where: ${returned_time} is not null
  persist_for: 1 hour
  joins:
    - join: orders
      view_label: 'My Orders'
      sql_on: ${orders.id} = ${order_items.order_id}
      relationship: many_to_one

    - join: users
      sql_on: ${users.id} = ${orders.user_id}
      relationship: many_to_one

