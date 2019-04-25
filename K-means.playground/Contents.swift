
//K-Mean  k均值算法

import UIKit
import PlaygroundSupport


//根据分类后得数据 重新计算聚类中心centers
func calculateCenters(points:Array<Array<CGPoint>>)-> Array<CGPoint> {

    var newCenters = Array<CGPoint>()
    for arr:Array<CGPoint> in points {
        
        var sumX:Double = 0
        var sumY:Double = 0
        for e in arr {
            sumX += Double(e.x)
            sumY += Double(e.y)
        }
        
        newCenters.append(CGPoint(x: sumX/Double(arr.count), y: sumY/Double(arr.count)))
    }
    
    return newCenters
}


/*
 根据提供的centers进行分类
 距离的度量方法:欧几里得距离
 */
func createClusters(centers:Array<CGPoint> , points:Array<CGPoint>) -> Array<Array<CGPoint>> {
    
    var array = Array<Array<CGPoint>>(repeating: [], count: centers.count)
    

    for p in points {
        
        var pow2 = Array<(Double,Int)>()
        for (i,c) in centers.enumerated() {
            let v = (c.x - p.x)*(c.x - p.x) + (c.y - p.y)*(c.y - p.y)
            let t = (Double(v),i)
            pow2.append(t)
        }
        
        let min = pow2.min { (x0, x1) -> Bool in
            return x0.0 <= x1.0
        }
        
        if let t = min {
            array[t.1].append(p)
        }
        
    }
    return array
}

/*
 计算所有中心点f误差是否都小于 minVarepsilon
 */
func lesserThanVarepsilon(points0:Array<CGPoint>,
                          points1:Array<CGPoint>,
                          varepsilon:Double) -> Bool {
    //验证误差小于 minVarepsilon
    var success = true
    for (i,cen) in points1.enumerated()
    {
        let p0  = points0[i]
        let p1  = cen as CGPoint
        let v : CGFloat = (p0.x - p1.x)*(p0.x - p1.x) + (p0.y - p1.y)*(p0.y - p1.y)
        
        //                print("p0:\(p0) p1:\(p1) v:\(sqrt(Double(v)))")
        
        let diff = sqrt(Double(v)) - varepsilon
        
        if abs(diff) > 0.01
        {
            //所有中心点的误差都得小于 minVarepsilon，又一个不小于继续循环
            success = false
            break
        }
        
    }
    
    return success
}


/*
 centers: 初始的中心点
 points: 需要分类的样本 CGPoint
 calculateTimes : 中心点计算次数,超过停止计算
 minVarepsilon ：最小可容忍误差
 */

func KMeans(centers:Array<CGPoint> ,
            points:Array<CGPoint>,
            maxCalculateTimes:Int,
            minVarepsilon:Double = 0)
    -> (Array<Array<CGPoint>> , Array<CGPoint>)
{
    
    var newCluters = createClusters(centers: centers, points: points)
    
    var newCenters:Array<CGPoint> = centers
    
    for _ in 1..<maxCalculateTimes {
        
        let lastCenters : Array<CGPoint> = newCenters
        
        newCenters = calculateCenters(points: newCluters)
        
        let success = lesserThanVarepsilon(points0: lastCenters, points1: newCenters,varepsilon: minVarepsilon)
        
        if success
        {
            print("相等")
            return (newCluters,newCenters)
        }else{
            newCluters = createClusters(centers: newCenters, points: points)
        }

    }

    return (newCluters,newCenters)
}












//test 测试

//随机测试样本（样本生成完成后分类已经基本知道了）
var array = [CGPoint]()

var randomX : Int {
    return Int.random(in: 1...50) * [1,2][Int.random(in: 0...1)]
}
var randomY : Int {
    return Int.random(in: 1...50) * [1,2][Int.random(in: 0...1)]
}

//第1类
for _ in 0..<10 {
    array.append(CGPoint(x: 150 + randomX, y: 25 + randomY))
}

//第2类
for _ in 0..<10 {
    array.append(CGPoint(x: 150 + randomX, y: 125 + randomY))
}
//第3类
for _ in 0..<10 {
    array.append(CGPoint(x: 150 + randomX, y: 225 + randomY))
}


//初始中心点
let centers:Array = [CGPoint(x: 150, y: 25),
                     CGPoint(x: 100, y: 125),
                     CGPoint(x: 150, y: 225),
                     CGPoint(x: 200, y: 225)]


let (arr,cen) = KMeans(centers:centers, points:array,maxCalculateTimes: 400 ,minVarepsilon: 0)

for a in arr {
    print("\(a)\n")
}

print(cen)

/*
为了方便测试，绘制分布view
注意：感觉是playground中得bug，绘图代码中得『注释』 在project中可以正常显示，但是在playground中不行 [xcode 10.2.1]
*/
class CustomView: UIView {
    
    var points:Array<Array<CGPoint>>?
    var centers:Array<CGPoint>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
//        context?.saveGState()
//        context?.setBlendMode(CGBlendMode.normal)
//        context?.setFillColor(UIColor.white.cgColor)
//        context?.fill(rect)
//        context?.restoreGState()

        context?.saveGState()
        
        let path = UIBezierPath()
        
        if let points = self.points
        {
            for (i,arr) in points.enumerated()
            {
                
                for p in arr
                {
//                    path.append(UIBezierPath(ovalIn: CGRect(x: p.x, y: p.y, width: 5, height: 5)))
                    
                    if let cens = self.centers
                    {
                        path.move(to: p)
                        path.addLine(to: cens[i])
                    }
                }
                
            }
        }
        
        context?.setFillColor(UIColor.red.cgColor)
        context?.setStrokeColor(UIColor.orange.cgColor)
        context?.addPath(path.cgPath)
        context?.drawPath(using: .fillStroke)
        context?.restoreGState()
        
    }
    
}

var mView = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
mView.points = arr
mView.centers = cen
PlaygroundPage.current.liveView = mView



