document.addEventListener("turbo:load", () => {
    const likeButtons = document.querySelectorAll(".like-btn");
  
    if (likeButtons.length === 0) {
      console.warn("No like buttons found on the page.");
    }
  
    likeButtons.forEach((button) => {
      button.addEventListener("click", (e) => {
        const postId = button.dataset.postId;
        if (!postId) {
          console.error("Post ID not found for like button");
          return;
        }
  
        const isLiked = button.classList.contains('text-red-500');
  
        const method = isLiked ? "DELETE" : "POST";
        const url = `/posts/${postId}/${isLiked ? "unlike" : "like"}`;
  
        fetch(url, {
          method: method,
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          },
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
          })
          .then((data) => {
            document.getElementById(`likes-count-${postId}`).textContent = data.likes_count;
  
            // Toggle color classes
            button.classList.toggle('text-red-500');
            button.classList.toggle('text-gray-400');
          })
          .catch((error) => {
            console.error("Error in fetch:", error);
          });
      });
    });
});