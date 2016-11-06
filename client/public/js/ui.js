 (function() {
  'use strict';

  window.election = window.election || {};

  window.election.toggleVisible = function toggleVisible(htmlElement) {
    htmlElement.toggleClass('visible');
  }

$('.show-candidate-list')
  .on('click', function showCandidate (event) {
    event.preventDefault();
    $('.list-of-candidates').addClass('visible')
    // window.election.toggleVisible($('.list-of-candidates'));

  });

  $('.show-create-candidates')
    .on('click', function createCandidate (event) {
      event.preventDefault();
    $('.create-a-candidate').addClass('visible');
    });

$('.create-a-candidate')
  .on('submit', function createCandidates(eventObj) {
    eventObj.preventDefault();
    var aboutCandidate = {};
    aboutCandidate.name = $('#name').val();
    aboutCandidate.image_url = $('#image_url').val();
    aboutCandidate.intelligence = $('#intelligence').val();
    aboutCandidate.charisma = $('#charisma').val();
    aboutCandidate.willpower = $('#willpower').val();
    console.log('hello');
    window.election.postCandidate(aboutCandidate);
});

$('.show-candidate-list')
  .on('click', function listOfCandidates(eventObj) {
    eventObj.preventDefault();
    window.election.getCandidates();
  });

  function createListOfCandidates (data){
    data.forEach(function (candidate){
      $('.list-of-candidates ul')
        .append('<li>' + candidate + '</li>');
    })

  };

  // function

// window.election.createCandidates = createCandidates();
window.election.createListOfCandidates = createListOfCandidates;

}());
