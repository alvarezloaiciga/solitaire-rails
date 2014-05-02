window.onresize = function(event) {
  var bodyWidth = $(document).width();
  if(bodyWidth < 1370){
    console.log(bodyWidth);
    $("#header").height(bodyWidth*0.167);
  }
  else{
    $("#header").height(222);
  }
};

$("#next-card-trigger").click(function(){
  $("#next-card-button").trigger('click');
});

$(document).ready(function() {
  enableDragAndDrop();
});

var draggableOptions = {
  revertDuration: 300,
  revert: function(isValidMove) {
    $(this).data({ revert: !isValidMove });
    return !isValidMove;
  },
  start: function(event, ui) {
    $('.last-card').droppable({ disabled: true });
    addEmptyClassToOriginColumn($('.original-parent'));
  },
  stop: function(event, ui) {
    if($(this).data("revert")) {
      removeEmptyCardFromEmptyColumn($('.original-parent'));
      $('.dragging-card').detach().appendTo($('.original-parent'));
    }
    $(this).removeData("revert");
    setDragAndDropAfterState();
  },
  helper: function(event, ui) {
    $('.card').not('.card-hidden').draggable({ disabled: true });
    $(this).parent().addClass('original-parent');
    selectDraggingCards($(this));
    var draggingGroup = $('<div />', { "class": 'dragging-group'});
    draggingGroup.appendTo($(this).parent());
    $('.dragging-card').detach().appendTo(draggingGroup);
    return draggingGroup;
  }
};

var emptyColumnDroppableOptions = {
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    columnID = $("#destiny_column_id").val();

    destinyColumnID = $("#destiny_column_id");
    destinyColumnID.val($(this).attr('id'));
    removeEmptyCardFromEmptyColumn($(this));
    $('.dragging-card').detach().appendTo($(this));

    moveOriginToDestiny(ui.draggable,$(this));
  }
};

var cardDroppableOptions = {
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    createDestinyCardID($(this));
    $('.dragging-card').detach().appendTo($(this).parent());
    moveOriginToDestiny(ui.draggable,$(this));
  }
};

function setDragAndDropAfterState() {
  $('.dragging-card').removeClass('dragging-card')
  $('.last-card').removeClass('last-card');
  $('.original-parent').removeClass('original-parent');
  enableDragAndDrop();
}

function enableDragAndDrop() {
  enableDraggableCards();
  enableDroppableEmptyColumns();
  enableDroppableCards();
};

function enableDraggableCards() {
  $( ".card" ).not(".card-hidden").draggable(draggableOptions);
  $( ".card" ).not(".card-hidden").draggable({ disabled: true });
  $( ".card" ).not(".card-hidden").draggable({ disabled: false });
};

function enableDroppableEmptyColumns() {
  $(".feeder_line_column").droppable(emptyColumnDroppableOptions);
  $(".product_line_column").droppable(emptyColumnDroppableOptions);
  $('.feeder_line_column').droppable({ disabled: true });
  $('.product_line_column').droppable({ disabled: true });
  $('.empty-column').droppable({ disabled: false});
};

function enableDroppableCards() {
  $( ".card" ).droppable(cardDroppableOptions);
  $('.card').droppable({ disabled: true });
  $('.feeder_line_column div.card:last-child').droppable({ disabled: false });
  $('.product_line_column div.card:last-child').droppable({ disabled: false });
};

function selectDraggingCards(card) {
  topMostCard(card);
  card.addClass('dragging-card');
  selectLastDraggingCard(card);
  card.nextAll().each(function(index) {
    topMostCard($(this));
    $(this).addClass('dragging-card');
  });
};

function selectLastDraggingCard(card) {
  if(card.is(':last-child')) {
    card.addClass('last-card');
  } else {
    card.nextAll().last().addClass('last-card');
  }
};

function createDestinyCardID(cardDiv) {
  destinyCardID = $("#destiny_card_id");
  destinyColumnID = $("#destiny_column_id");

  destinyCardID.val(cardDiv.attr('id'));
  destinyColumnID.val(cardDiv.parent().attr('id'));
};

function createOriginCardID(cardDiv) {
  originCardID = $("#origin_card_id");
  originColumnID = $("#origin_column_id");

  originCardID.val(cardDiv.attr('id'));
  originColumnID.val($('.original-parent').attr('id'));
};

function moveOriginToDestiny(originCard,destinyCard) {
  columnID = $("#destiny_column_id").val();

  if(columnID.match(/product_line_column/)){
    originCard.addClass("product-line-card");
  }

  $("#move-card-button").trigger('click');

  if(columnID.match(/feeder_line_column/)){
    var highest_margin_bottom = destinyCard.css('margin-bottom');

    if (highest_margin_bottom == '-209px') { 
      destinyCard.css('margin-bottom', '-180px');
    }
  }
}

function topMostCard(card)
{
  var elements = document.getElementsByClassName("card");
  var highest_index = 0;

  for (var i = 0; i < elements.length - 1; i++) {
    if (parseInt(elements[i].style.zIndex) > highest_index) {
      highest_index = parseInt(elements[i].style.zIndex);
    }
  }
  card.css('zIndex', highest_index + 1);
};

function addEmptyClassToOriginColumn(originColumn) {
  if(originColumn.children().length == 1 && !originColumn.hasClass('train')) {
    originColumn.addClass('empty-column');
    originColumn.append($('<img />', { "alt": 'Empty', "src": '/assets/deck/empty.png' }));
  }
};

function addEmptyClassToDestinyColumn(destinyColumn) {
  if(destinyColumn.children().length == 0) {
    destinyColumn.addClass('empty-column');
    destinyColumn.append($('<img />', { "alt": 'Empty', "src": '/assets/deck/empty.png' }));
  }
};

function removeEmptyCardFromEmptyColumn(column) {
  if(column.hasClass('empty-column')) {
    column.find("img[alt*='Empty']").remove();
    column.removeClass("empty-column");
  }
};

$("#train-card").click(function(){
  $(this).toggleClass("train-card-selected");
});