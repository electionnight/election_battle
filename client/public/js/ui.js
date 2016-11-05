 (function() {
  'use strict';

  window.election = window.election || {};


// $('.show-candidate-list')
//   .on('click', function showCandidate (event) {
//     event.preventDefault();
//     $('.show-candidate-list').toggleClass('visible');
//     console.log('worked');
//   });
//
//   $('.show-create-candidates')
//     .on('click', function createCandidate (event) {
//       event.preventDefault();
//       $('.show-create-candidates').toggleClass('visible');
//       console.log('worked');
//     });

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



// window.election.createCandidates = createCandidates();

}());
