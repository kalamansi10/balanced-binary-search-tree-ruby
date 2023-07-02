class Node
    include Comparable
    attr_accessor :left, :right, :data
    def initialize(data)
        @left = nil
        @data = data
        @right = nil
    end
    def <=>(other_data)
        data <=> other_data.data
    end
end

class Tree
    attr_accessor :root
    def initialize(array)
        @root = build_tree(array)
    end
    def build_tree(array)
        mid = array.length / 2
        return root = Node.new(array[0]) if array[0] == array[-1]
        root = Node.new(array[mid])
        root.left = build_tree(array[0..mid - 1])
        root.right = build_tree(array[mid + 1..-1])
        root
    end
    def insert(input)
        input_node = Node.new(input)
        insert_node(input_node)
    end
    def insert_node(input_node)
        node = root
        until (node > input_node && !node.left) || (node < input_node && !node.right)
            if node > input_node
                node = node.left
                next
            elsif node < input_node
                node = node.right 
                next
            end
        end
        node.left = input_node if node > input_node
        node.right = input_node if node < input_node
    end
    def delete(input)
        input_node = Node.new(input)
        if root == input_node
            delete_root
            return
        end
        node = node_at(input_node)
        temp_node = node.left == input_node ? node.left : node.right
        if !temp_node.right && !temp_node.left
            case temp_node
            when node.left
                node.left = nil
            when node.right
                node.right = nil
            end
        else
            prefix_node = temp_node.right 
            suffix_node = temp_node.left 
            node.left = prefix_node if node.left == input_node
            node.right = prefix_node if node.right == input_node
            insert_node(suffix_node) unless !suffix_node
        end
    end
    def delete_root
        prefix_node = root.right
        suffix_node = root.left
        root = prefix_node
        insert_node(suffix_node)
    end
    def find(input)
        input_node = Node.new(input)
        return root if input_node == root
        node = node_at(input_node)
        node.left == input_node ? node.left : node.right
    end
    def node_at(input_node)
        node = root
        until node.left == input_node || node.right == input_node
            if node > input_node
                node = node.left
                next
            elsif node < input_node
                node = node.right
                next
            end
        end
        node
    end
    def level_order
        node = root
        queue = []
        data_array = []
        queue << node
        until !queue[0]
            node = queue[0]
            yield queue[0] if block_given?
            data_array << queue[0].data
            queue << node.left
            queue << node.right
            queue.shift
        end
        data_array unless block_given?
    end
    def inorder(&block)
        node = root
        data_array = []
        p block if block_given?
        inorder_search(node, data_array, &block)
        data_array unless block_given?
    end
    def inorder_search(node, data_array, &block)
        inorder_search(node.left, data_array, &block) unless !node.left
        data_array << node.data
        block.call(node) if block_given?
        inorder_search(node.right, data_array, &block) unless !node.right
    end
    def preorder(&block)
        node = root
        data_array = []
        p block if block_given?
        preorder_search(node, data_array, &block)
        data_array unless block_given?
    end
    def preorder_search(node, data_array, &block)
        data_array << node.data
        block.call(node) if block_given?
        preorder_search(node.left, data_array, &block) unless !node.left
        preorder_search(node.right, data_array, &block) unless !node.right
    end
    def postorder(&block)
        node = root
        data_array = []
        p block if block_given?
        postorder_search(node, data_array, &block)
        data_array unless block_given?
    end
    def postorder_search(node, data_array, &block)
        postorder_search(node.left, data_array, &block) unless !node.left
        postorder_search(node.right, data_array, &block) unless !node.right
        data_array << node.data
        block.call(node) if block_given?
    end
    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
    
end

bin_tree = Tree.new([9,8,7,6,5,4,3,2,1])
bin_tree.insert(3)
bin_tree.insert(2)
bin_tree.pretty_print
i = bin_tree.find(5)
p bin_tree.height(i)


# bin_tree = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
# bin_tree = Tree.new([1,4,7,10,13,16,19])
# bin_tree.pretty_print
# bin_tree.insert(5)
# bin_tree.insert(3)
# bin_tree.insert(2)
# bin_tree.pretty_print
# bin_tree.delete(2)
# bin_tree.pretty_print
# bin_tree.level_order

