# Memorize Game

Learning Swift UI by following [this course](https://cs193p.sites.stanford.edu)

## Notes

- On Lecture 3, I couldn't get the cards to flip following along with their code. I tried heaps of stuff and concluded that the
  card in the CardView struct was not in sync with the model. I couldn't quite figure out why this was the case. I worked around
  the issue by sending the content and bool flag as params to the view rather than the card object itself
- I'm not entirely sure where the best place for modifier is. In the lecture he seems to favour putting them in the parent view (e.g 
  `aspectRatio`) but my instinct tells me it should live closer to the child view. Something to think about. 
