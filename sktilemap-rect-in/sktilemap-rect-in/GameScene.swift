import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private let tileSize = CGSize(width: 32, height: 32)

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        let tileSet = createTileSet()
        let tileMap = SKTileMapNode(tileSet: tileSet,
                                    columns: 100,
                                    rows: 100,
                                    tileSize: tileSize)

        for column in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                guard let tileGroup = tileSet.tileGroups.randomElement() else {
                    fatalError()
                }
                tileMap.setTileGroup(tileGroup, forColumn: column, row: row)
            }
        }
        addChild(tileMap)
    }

    private func createTileSet() -> SKTileSet {
        let tileSheetTexture = SKTexture(imageNamed: "terrain")
        var tileGroups = [SKTileGroup]()
        let relativeTileSize = CGSize(width: tileSize.width/tileSheetTexture.size().width,
                                      height: tileSize.height/tileSheetTexture.size().height)
        for idx in 0...2 {
            for jdx in 0...2 {
                let tileTexture = SKTexture(rect: .init(x: CGFloat(idx) * relativeTileSize.width,
                                                        y: CGFloat(jdx) * relativeTileSize.height,
                                                        width: relativeTileSize.width,
                                                        height: relativeTileSize.height),
                                            in: tileSheetTexture)
                let tileDefinition = SKTileDefinition(texture: tileTexture,
                                                      size: tileSize)
                let tileGroup = SKTileGroup(tileDefinition: tileDefinition)
                tileGroups.append(tileGroup)
            }
        }

        let tileSet = SKTileSet(tileGroups: tileGroups)
        return tileSet
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presentSceneAgain()
    }

    func presentSceneAgain() {
        if let frame = view?.frame {
            view?.presentScene(GameScene(size: frame.size),
                               transition: .doorsCloseHorizontal(withDuration: 1.0))
        }
    }
}
