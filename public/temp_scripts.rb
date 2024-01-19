s = PaperElement.first
data = {s.id => s.get_answer_preview}
s.calculate_result(data)