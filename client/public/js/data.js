(function() {
  'use strict';

  window.election = window.election || {};

  function getCandidates() {
    $.ajax({
      url: '/candidates',
      method: 'GET',
      dataType: 'json',
    })
    .done(function(data){
      console.log(data);
      window.election.createListOfCandidates(data);
    })
    .fail(function(data){
      console.log('fail');
    })
  };

  function postCandidate(aboutCandidate) {
    var candidateName = aboutCandidate.name
    var avatar = aboutCandidate.image_url
    var intelligence = aboutCandidate.intelligence
    var charisma = aboutCandidate.charisma
    var willpower = aboutCandidate.willpower
    console.log(aboutCandidate);
    // do ajax call, url, metho, data json

    $.ajax({
      url: '/candidates',
      method: 'POST',
      data: JSON.stringify({name: candidateName,
            image_url: avatar,
            intelligence: intelligence,
            charisma: charisma,
            willpower: willpower
            
      }),
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .done( function handleSuccess(data) {
      console.log(data);
    })
    .fail (function handleFail(xhr, errorType) {
      console.log(xhr);
    });
  };

  // window.election.postCandidate = postCandidate;

window.election.postCandidate = postCandidate;
window.election.getCandidates = getCandidates;
}());
