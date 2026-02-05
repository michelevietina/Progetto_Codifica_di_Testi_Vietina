document.addEventListener("DOMContentLoaded", function() {

    // Funzione generica di evidenziazione
    function toggleHighlight(selector, cssClass) {
        document.querySelectorAll(selector).forEach(el => {
            el.classList.toggle(cssClass);
        });
    }

    // Persone
    document.getElementById("persone").onclick = function() {
        toggleHighlight(".persName", "hl-person");
    };

    // Luoghi
    document.getElementById("luoghi").onclick = function() {
        toggleHighlight(".placeName", "hl-place");
    };

    // Date
    document.getElementById("date").onclick = function() {
        toggleHighlight(".date", "hl-date");
    };

    // Organizzazioni
    document.getElementById("organizzazioni").onclick = function() {
        toggleHighlight(".orgName", "hl-org");
    };

    // Citazioni
    document.getElementById("citazioni").onclick = function() {
        toggleHighlight(".citazione", "hl-quote");
    };

    // Opere
    document.getElementById("opere").onclick = function() {
        toggleHighlight(".opere", "hl-opere");
    };

    // Popoli
    document.getElementById("popoli").onclick = function() {
        toggleHighlight(".popoli", "hl-people");
    };

    // Lingue straniere
    document.getElementById("foreign").onclick = function() {
        toggleHighlight(".foreign", "hl-foreign");
    };


     let currentDesc = 0;
    const descSlides = document.querySelectorAll(".desc-slide");
    const descDots = document.querySelectorAll(".desc-indicators .dot");

    function showDesc(index) {
        descSlides.forEach(s => s.classList.remove("active"));
        descDots.forEach(d => d.classList.remove("active"));

        descSlides[index].classList.add("active");
        descDots[index].classList.add("active");
    }

    if (descSlides.length > 0) {
        setInterval(() => {
            currentDesc = (currentDesc + 1) % descSlides.length;
            showDesc(currentDesc);
        }, 5000);
    }


});




function evidenziaParagrafo(id) {

    console.log("Chiamato evidenziaParagrafo per:", id);

    // pulizia evidenziazioni precedenti
    document.querySelectorAll(".paragrafo").forEach(p => p.classList.remove("active"));
    document.querySelectorAll(".zone-overlay").forEach(z => z.classList.remove("active"));

    // evidenzia paragrafo nel testo
    let p = document.querySelector(`#${id}`);
    if (p) p.classList.add("active");

    // evidenzia TUTTE le zone collegate
    document.querySelectorAll(`.zone-overlay[data-corresp="#${id}"]`)
        .forEach(z => z.classList.add("active"));
}

// RENDI LA FUNZIONE VISIBILE GLOBALMENTE
window.evidenziaParagrafo = evidenziaParagrafo;


let lastScrollY = 0;

window.addEventListener("scroll", function () {

    const header = document.querySelector("header");

    if (window.scrollY === 0) {
        // L'utente è ESATTAMENTE in cima → navbar normale
        header.classList.remove("nav-fixed");
        return;
    }

    if (window.scrollY > lastScrollY) {
        // L'utente SCENDE → navbar sticky
        header.classList.add("nav-fixed");
    } else if (window.scrollY < lastScrollY && window.scrollY > 0) {
        // L'utente SALE ma non è in cima → navbar comunque sticky
        header.classList.add("nav-fixed");
    }

    lastScrollY = window.scrollY;
});

$(document).ready(function() {

    $(".bottoni_fenomeni button").on("click", function() {

        // toggla la classe attiva
        $(this).toggleClass("active");

    });

});

