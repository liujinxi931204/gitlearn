import java.util.Stack;

/**
 * author liujinxi@sogou-inc.com
 * date 2020-03-23 10:05
 **/
public class binaryTreeDaemon {
    public static void main(String[] args) {
        BinaryTree BinaryTree = new BinaryTree();
        treeNode root=new treeNode(1);
        treeNode node1=new treeNode(2);
        treeNode node2=new treeNode(3);
        treeNode node3=new treeNode(4);
        treeNode node4=new treeNode(5);
        treeNode node5=new treeNode(6);
        treeNode node6=new treeNode(7);
        root.left=node1;
        root.right=node2;
        node1.left=node3;
        node1.right=node4;
        node2.left=node5;
        node2.right=node6;
        BinaryTree.setRoot(root);
        BinaryTree.preOrder(root);
        BinaryTree.midOrder(root);

    }
}

class treeNode{
    private int data;
    public treeNode left;
    public treeNode right;

    public treeNode(int data){
        this.data=data;
    }

    public int getData() {
        return data;
    }

    public void setData(int data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "treeNode{" +
                "data=" + data +
                '}';
    }
}

class BinaryTree{
    public treeNode root;

    public void setRoot(treeNode root){
        this.root=root;
    }

    public void preOrder(treeNode node){
        Stack<treeNode> stack=new Stack<>();
        while(node!=null || !stack.isEmpty()) {
            while(node!=null){
                System.out.println(node.getData());
                stack.push(node);
                node=node.left;
            }
            if(!stack.isEmpty()){
                node=stack.pop();
                node=node.right;
            }
        }
    }
    
    
    public void midOrder(treeNode node){
        Stack<treeNode> stack=new Stack<>();
        while(node!=null|| !stack.isEmpty()) {
            while (node!=null){
                stack.push(node);
                node=node.left;
            }
            if(!stack.isEmpty()){
                node=stack.pop();
                System.out.println(node.getData());
                node=node.right;
            }
        }
    }
    
    public void midOrder(treeNode node){
        if(node==null){
            return;
        }
        midOrder(node.left);
        system.out.println(node);
        mieOrder(node.right);
    }
    

    public void postOrder(treeNode node){
        int LEFT=1;
        int RIGHT=2;
        Stack<treeNode> stack=new Stack<>();
        Stack<Integer> stack1=new Stack<>();
        while(node!=null|| !stack.isEmpty()){
            while(node!=null){
                stack.push(node);
                stack1.push(LEFT);
                node=node.left;
            }
        }
    }
}
