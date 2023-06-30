class Node
    include Comparable
    attr_accessor :left, :right, :data
    def initialize(data)
        @left = left
        @data = data
        @right = right
    end
end

class Tree
    attr_accessor :root
    def initialize(array)
        @root = build_tree(array)
    end
    def build_tree(array)
        mid = array.length / 2
        if array[0] == array[-1]
            root = Node.new(array[0])
            root.left = nil
            root.right = nil
            return root
        end
        root = Node.new(array[mid])
        root.left = build_tree(array[0..mid - 1])
        root.right = build_tree(array[mid + 1..-1])
        root
    end
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
      
end

bin_tree = Tree.new([1,2,3,4,5,6,7,8,9])
p bin_tree.pretty_print