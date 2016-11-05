(function() {
  'use strict';

  window.election = window.election || {};

  function postCandidate(aboutCandidates) {
  window.election.postCandidate = postCandidate;

    var candidateName = aboutCandidate.name
    var avatar = aboutCandidate.image_url
    var intelligence = aboutCandidate.intelligence
    var charisma = aboutCandidate.charisma
    var willpower = aboutCandidate.willpower
    console.log(aboutCandidates);
    // do ajax call, url, metho, data json

    $.ajax({

      url: '/candidates',
      method: 'POST',
      data: JSON.stringify({name: candidateName,
            image_url: avatar,
            intelligence: intelligence,
            charisma: charisma,
            willpower: willpower
            campaigns-won:
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

  });



window.election.postCandidate = postCandidate;

}());
