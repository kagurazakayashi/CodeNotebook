switch index {
	case 0: // fmt.Sprintf
		s = fmt.Sprintf("%s[%s]", s, v)
	case 1: // string +
		s = s + "[" + v + "]"
	case 2: // strings.Join
		s = strings.Join([]string{s, "[", v, "]"}, "")
	case 3: // stable bytes.Buffer
		buf.WriteString("[")
		buf.WriteString(v)
		buf.WriteString("]")
}