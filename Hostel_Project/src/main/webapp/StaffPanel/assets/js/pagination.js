/*document.addEventListener('DOMContentLoaded', function() {
    const prevButton = document.getElementById('prev-page');
    const nextButton = document.getElementById('next-page');
    const pageNumberInput = document.getElementById('page-number');

    let currentPage = 1;
    const totalPages = 10;

    function updatePagination() {
        pageNumberInput.value = currentPage;
        prevButton.disabled = (currentPage === 1);
        nextButton.disabled = (currentPage === totalPages);
    }

    function goToPage(page) {
        if (page < 1 || page > totalPages) return;
        currentPage = page;
        updatePagination();
        // Fetch data for the new page (backend integration needed)
    }

    prevButton.addEventListener('click', function() {
        goToPage(currentPage - 1);
    });

    nextButton.addEventListener('click', function() {
        goToPage(currentPage + 1);
    });

    pageNumberInput.addEventListener('change', function() {
        goToPage(parseInt(pageNumberInput.value, 10));
    });

    updatePagination();
});*/