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
  revert: function(isValidMove) {
    if(!isValidMove) {
      removeEmptyCardFromEmptyColumn($('.original-parent'));
      $('.dragging-card').detach().appendTo($('.original-parent'));
    }
    return !isValidMove;
  },
  start: function(event, ui) {
    $('.last-card').droppable({ disabled: true });
    addEmptyClassToOriginColumn($('.original-parent'));
  },
  stop: function(event, ui) {
    setDragAndDropAfterState();
  },
  helper: function(event, ui) {
    $(this).parent().addClass('original-parent');
    selectDraggingCards($(this));
    var draggingGroup = $('<div />', { "class": 'dragging-group feeder_line_column'});
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
    $('.dragging-card').detach().appendTo($('body'));

    moveOriginToDestiny(ui.draggable);
  }
};

var cardDroppableOptions = {
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    createDestinyCardID($(this));
    $('.dragging-card').detach().appendTo($('body'));
    moveOriginToDestiny(ui.draggable);
  }
};

function setDragAndDropAfterState() {
  $('div.dragging-card').removeClass('dragging-card')
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

function moveOriginToDestiny(originCard) {
  columnID = $("#destiny_column_id").val();

  if(columnID.match(/product_line_column/)){
    originCard.addClass("product-line-card");
  }

  $("#move-card-button").trigger('click');
};

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

function removeEmptyCardFromEmptyColumn(column) {
  if(column.hasClass('empty-column')) {
    column.find("img[alt*='Empty']").remove();
    column.removeClass("empty-column");
  }
};

$("#train-card").click(function(){
  $(this).toggleClass("train-card-selected");
});
