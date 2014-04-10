//
//  Shader.fsh
//  water
//
//  Created by  Apple on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
