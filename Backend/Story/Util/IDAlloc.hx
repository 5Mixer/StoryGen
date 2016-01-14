package story.util;

class IDAlloc {
    static var idCount:Int = 0;
    public static function get(){
        idCount++;
        return idCount;
    }
}
