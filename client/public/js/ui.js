 (function() {
  'use strict';

  window.election = window.election || {};

  // window.election.toggleVisible = function toggleVisible(htmlElement) {
  //   htmlElement.toggleClass('visible');


$('.show-candidate-list')
  .on('click', function showCandidate (event) {
    event.preventDefault();
    $('.list-of-candidates').addClass('visible');
    $('nav').removeClass('visible');
    window.election.toggleVisible($('.list-of-candidates'));

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

  function createListOfCandidates (data) {
    data.forEach(function addEachtoUl(candidate){
      $('.list-of-candidates ul')
        .append(
          '<li>' + candidate.id +
          '<img src = "' + candidate.image_url + '">  ' +
          candidate.name + " ( " + "Intelligence: " + candidate.intelligence + ", " + " Charisma: " + candidate.charisma + ", " + " Willpower: " + candidate.willpower + " ) " +
          '<button>Delete</button>' +
          '<button>Update</button>' +
          '</li>'
        );
    })
  }

  $('.show-old-campaign')
    .on('click', function showCampaigns (event) {
      event.preventDefault();
    $('.see-old-campaigns').addClass('visible');
    console.log(yes);
    });

$('.show-create-campaign')
  .on('click', function runCampaign (event){
    event.preventDefault();
    $('.create-campaign').addClass('visible');
  });






  // function

// window.election.createCandidates = createCandidates();
window.election.createListOfCandidates = createListOfCandidates;

}());
