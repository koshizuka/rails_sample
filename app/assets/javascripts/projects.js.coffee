helper1 = (e, tr) ->
  $originals = tr.children()
  $helper = tr.clone()
  $helper.children().each (index) ->
    $(this).width $originals.eq(index).width()
    return
  $helper

$ ->
  # $(".task_table").tablefix({width: 1150, height: 420, fixRows: 2, fixCols: 4});
  $('#sortable-table tbody').sortable
    helper: helper1
    axis: "y"
    cursor: 'move'
    update: (event, ui) ->
      $.ajax (document.URL + "/tasks/27/sort"),
        type: "POST",
        dateType: "script",
        data: {
          "task-id": $(ui.item[0]).attr("data-task-id")
          "order": ui.item[0].sectionRowIndex
        }

  $(".planed_time").on "change", ->
    alert "あ"