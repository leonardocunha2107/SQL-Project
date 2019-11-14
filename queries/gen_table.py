with open("profiling.txt", "r", encoding="utf-8") as f:
    print("\\begin{center}\n\t\\begin{tabular}{ || c  c  c  c  c  c || }\n\t\t\\hline\n\t\tQuery & Time1 (ms) & Time 2 (ms) & Time3(ms) & Time4 (ms) & Time5 (ms)  \\\\ \\hline")
    lines = f.readlines()
    lines = [l.strip() for l in lines]
    
    for i in range(0, len(lines), 6):
        n = lines[i]
        times = [str(round(float(l))) for l in lines[i + 1:i + 6]]
        print('\t\t' + ' & '.join([n] + times) + ' \\\\ \\hline')

    print("\t\\end{tabular}\n\\end{center}")
