//
//  ID3v2FrameID.swift
//  Metatron
//
//  Copyright (c) 2016 Almaz Ibragimov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public class ID3v2FrameID: Hashable {

    // MARK: Type Properties

    public static let aenc = ID3v2FrameID(nativeID: "AENC", signatures: [ID3v2Version.v2: [67, 82, 65],
                                                                         ID3v2Version.v3: [65, 69, 78, 67],
                                                                         ID3v2Version.v4: [65, 69, 78, 67]])

    public static let apic = ID3v2FrameID(nativeID: "APIC", signatures: [ID3v2Version.v2: [80, 73, 67],
                                                                         ID3v2Version.v3: [65, 80, 73, 67],
                                                                         ID3v2Version.v4: [65, 80, 73, 67]])

    public static let aspi = ID3v2FrameID(nativeID: "ASPI", signatures: [ID3v2Version.v4: [65, 83, 80, 73]])

    public static let comm = ID3v2FrameID(nativeID: "COMM", signatures: [ID3v2Version.v2: [67, 79, 77],
                                                                         ID3v2Version.v3: [67, 79, 77, 77],
                                                                         ID3v2Version.v4: [67, 79, 77, 77]])

    public static let comr = ID3v2FrameID(nativeID: "COMR", signatures: [ID3v2Version.v3: [67, 79, 77, 82],
                                                                         ID3v2Version.v4: [67, 79, 77, 82]])

    public static let crm = ID3v2FrameID(nativeID: "CRM", signatures: [ID3v2Version.v2: [67, 82, 77]])

    public static let encr = ID3v2FrameID(nativeID: "ENCR", signatures: [ID3v2Version.v3: [69, 78, 67, 82],
                                                                         ID3v2Version.v4: [69, 78, 67, 82]])

    public static let equa = ID3v2FrameID(nativeID: "EQUA", signatures: [ID3v2Version.v2: [69, 81, 85],
                                                                         ID3v2Version.v3: [69, 81, 85, 65]])

    public static let equ2 = ID3v2FrameID(nativeID: "EQU2", signatures: [ID3v2Version.v4: [69, 81, 85, 50]])

    public static let etco = ID3v2FrameID(nativeID: "ETCO", signatures: [ID3v2Version.v2: [69, 84, 67],
                                                                         ID3v2Version.v3: [69, 84, 67, 79],
                                                                         ID3v2Version.v4: [69, 84, 67, 79]])

    public static let geob = ID3v2FrameID(nativeID: "GEOB", signatures: [ID3v2Version.v2: [71, 69, 79],
                                                                         ID3v2Version.v3: [71, 69, 79, 66],
                                                                         ID3v2Version.v4: [71, 69, 79, 66]])

    public static let grid = ID3v2FrameID(nativeID: "GRID", signatures: [ID3v2Version.v3: [71, 82, 73, 68],
                                                                         ID3v2Version.v4: [71, 82, 73, 68]])

    public static let ipls = ID3v2FrameID(nativeID: "IPLS", signatures: [ID3v2Version.v2: [73, 80, 76],
                                                                         ID3v2Version.v3: [73, 80, 76, 83]])

    public static let link = ID3v2FrameID(nativeID: "LINK", signatures: [ID3v2Version.v2: [76, 78, 75],
                                                                         ID3v2Version.v3: [76, 73, 78, 75],
                                                                         ID3v2Version.v4: [76, 73, 78, 75]])

    public static let mcdi = ID3v2FrameID(nativeID: "MCDI", signatures: [ID3v2Version.v2: [77, 67, 73],
                                                                         ID3v2Version.v3: [77, 67, 68, 73],
                                                                         ID3v2Version.v4: [77, 67, 68, 73]])

    public static let mllt = ID3v2FrameID(nativeID: "MLLT", signatures: [ID3v2Version.v2: [77, 76, 76],
                                                                         ID3v2Version.v3: [77, 76, 76, 84],
                                                                         ID3v2Version.v4: [77, 76, 76, 84]])

    public static let owne = ID3v2FrameID(nativeID: "OWNE", signatures: [ID3v2Version.v3: [79, 87, 78, 69],
                                                                         ID3v2Version.v4: [79, 87, 78, 69]])

    public static let priv = ID3v2FrameID(nativeID: "PRIV", signatures: [ID3v2Version.v3: [80, 82, 73, 86],
                                                                         ID3v2Version.v4: [80, 82, 73, 86]])

    public static let pcnt = ID3v2FrameID(nativeID: "PCNT", signatures: [ID3v2Version.v2: [67, 78, 84],
                                                                         ID3v2Version.v3: [80, 67, 78, 84],
                                                                         ID3v2Version.v4: [80, 67, 78, 84]])

    public static let popm = ID3v2FrameID(nativeID: "POPM", signatures: [ID3v2Version.v2: [80, 79, 80],
                                                                         ID3v2Version.v3: [80, 79, 80, 77],
                                                                         ID3v2Version.v4: [80, 79, 80, 77]])

    public static let poss = ID3v2FrameID(nativeID: "POSS", signatures: [ID3v2Version.v3: [80, 79, 83, 83],
                                                                         ID3v2Version.v4: [80, 79, 83, 83]])

    public static let rbuf = ID3v2FrameID(nativeID: "RBUF", signatures: [ID3v2Version.v2: [66, 85, 70],
                                                                         ID3v2Version.v3: [82, 66, 85, 70],
                                                                         ID3v2Version.v4: [82, 66, 85, 70]])

    public static let rvad = ID3v2FrameID(nativeID: "RVAD", signatures: [ID3v2Version.v2: [82, 86, 65],
                                                                         ID3v2Version.v3: [82, 86, 65, 68]])

    public static let rva2 = ID3v2FrameID(nativeID: "RVA2", signatures: [ID3v2Version.v4: [82, 86, 65, 50]])

    public static let rvrb = ID3v2FrameID(nativeID: "RVRB", signatures: [ID3v2Version.v2: [82, 69, 86],
                                                                         ID3v2Version.v3: [82, 86, 82, 66],
                                                                         ID3v2Version.v4: [82, 86, 82, 66]])

    public static let seek = ID3v2FrameID(nativeID: "SEEK", signatures: [ID3v2Version.v4: [83, 69, 69, 75]])

    public static let sign = ID3v2FrameID(nativeID: "SIGN", signatures: [ID3v2Version.v4: [83, 73, 71, 78]])

    public static let sylt = ID3v2FrameID(nativeID: "SYLT", signatures: [ID3v2Version.v2: [83, 76, 84],
                                                                         ID3v2Version.v3: [83, 89, 76, 84],
                                                                         ID3v2Version.v4: [83, 89, 76, 84]])

    public static let sytc = ID3v2FrameID(nativeID: "SYTC", signatures: [ID3v2Version.v2: [83, 84, 67],
                                                                         ID3v2Version.v3: [83, 89, 84, 67],
                                                                         ID3v2Version.v4: [83, 89, 84, 67]])

    public static let talb = ID3v2FrameID(nativeID: "TALB", signatures: [ID3v2Version.v2: [84, 65, 76],
                                                                         ID3v2Version.v3: [84, 65, 76, 66],
                                                                         ID3v2Version.v4: [84, 65, 76, 66]])

    public static let tbpm = ID3v2FrameID(nativeID: "TBPM", signatures: [ID3v2Version.v2: [84, 66, 80],
                                                                         ID3v2Version.v3: [84, 66, 80, 77],
                                                                         ID3v2Version.v4: [84, 66, 80, 77]])

    public static let tcom = ID3v2FrameID(nativeID: "TCOM", signatures: [ID3v2Version.v2: [84, 67, 77],
                                                                         ID3v2Version.v3: [84, 67, 79, 77],
                                                                         ID3v2Version.v4: [84, 67, 79, 77]])

    public static let tcon = ID3v2FrameID(nativeID: "TCON", signatures: [ID3v2Version.v2: [84, 67, 79],
                                                                         ID3v2Version.v3: [84, 67, 79, 78],
                                                                         ID3v2Version.v4: [84, 67, 79, 78]])

    public static let tcop = ID3v2FrameID(nativeID: "TCOP", signatures: [ID3v2Version.v2: [84, 67, 82],
                                                                         ID3v2Version.v3: [84, 67, 79, 80],
                                                                         ID3v2Version.v4: [84, 67, 79, 80]])

    public static let tden = ID3v2FrameID(nativeID: "TDEN", signatures: [ID3v2Version.v4: [84, 68, 69, 78]])

    public static let tdat = ID3v2FrameID(nativeID: "TDAT", signatures: [ID3v2Version.v2: [84, 68, 65],
                                                                         ID3v2Version.v3: [84, 68, 65, 84]])

    public static let tdly = ID3v2FrameID(nativeID: "TDLY", signatures: [ID3v2Version.v2: [84, 68, 89],
                                                                         ID3v2Version.v3: [84, 68, 76, 89],
                                                                         ID3v2Version.v4: [84, 68, 76, 89]])

    public static let tdor = ID3v2FrameID(nativeID: "TDOR", signatures: [ID3v2Version.v4: [84, 68, 79, 82]])

    public static let tdrc = ID3v2FrameID(nativeID: "TDRC", signatures: [ID3v2Version.v4: [84, 68, 82, 67]])

    public static let tdrl = ID3v2FrameID(nativeID: "TDRL", signatures: [ID3v2Version.v4: [84, 68, 82, 76]])

    public static let tdtg = ID3v2FrameID(nativeID: "TDTG", signatures: [ID3v2Version.v4: [84, 68, 84, 71]])

    public static let tenc = ID3v2FrameID(nativeID: "TENC", signatures: [ID3v2Version.v2: [84, 69, 78],
                                                                         ID3v2Version.v3: [84, 69, 78, 67],
                                                                         ID3v2Version.v4: [84, 69, 78, 67]])

    public static let text = ID3v2FrameID(nativeID: "TEXT", signatures: [ID3v2Version.v2: [84, 88, 84],
                                                                         ID3v2Version.v3: [84, 69, 88, 84],
                                                                         ID3v2Version.v4: [84, 69, 88, 84]])

    public static let tflt = ID3v2FrameID(nativeID: "TFLT", signatures: [ID3v2Version.v2: [84, 70, 84],
                                                                         ID3v2Version.v3: [84, 70, 76, 84],
                                                                         ID3v2Version.v4: [84, 70, 76, 84]])

    public static let tipl = ID3v2FrameID(nativeID: "TIPL", signatures: [ID3v2Version.v4: [84, 73, 80, 76]])

    public static let time = ID3v2FrameID(nativeID: "TIME", signatures: [ID3v2Version.v2: [84, 73, 77],
                                                                         ID3v2Version.v3: [84, 73, 77, 69]])

    public static let tit1 = ID3v2FrameID(nativeID: "TIT1", signatures: [ID3v2Version.v2: [84, 84, 49],
                                                                         ID3v2Version.v3: [84, 73, 84, 49],
                                                                         ID3v2Version.v4: [84, 73, 84, 49]])

    public static let tit2 = ID3v2FrameID(nativeID: "TIT2", signatures: [ID3v2Version.v2: [84, 84, 50],
                                                                         ID3v2Version.v3: [84, 73, 84, 50],
                                                                         ID3v2Version.v4: [84, 73, 84, 50]])

    public static let tit3 = ID3v2FrameID(nativeID: "TIT3", signatures: [ID3v2Version.v2: [84, 84, 51],
                                                                         ID3v2Version.v3: [84, 73, 84, 51],
                                                                         ID3v2Version.v4: [84, 73, 84, 51]])

    public static let tkey = ID3v2FrameID(nativeID: "TKEY", signatures: [ID3v2Version.v2: [84, 75, 69],
                                                                         ID3v2Version.v3: [84, 75, 69, 89],
                                                                         ID3v2Version.v4: [84, 75, 69, 89]])

    public static let tlan = ID3v2FrameID(nativeID: "TLAN", signatures: [ID3v2Version.v2: [84, 76, 65],
                                                                         ID3v2Version.v3: [84, 76, 65, 78],
                                                                         ID3v2Version.v4: [84, 76, 65, 78]])

    public static let tlen = ID3v2FrameID(nativeID: "TLEN", signatures: [ID3v2Version.v2: [84, 76, 69],
                                                                         ID3v2Version.v3: [84, 76, 69, 78],
                                                                         ID3v2Version.v4: [84, 76, 69, 78]])

    public static let tmcl = ID3v2FrameID(nativeID: "TMCL", signatures: [ID3v2Version.v4: [84, 77, 67, 76]])

    public static let tmed = ID3v2FrameID(nativeID: "TMED", signatures: [ID3v2Version.v2: [84, 77, 84],
                                                                         ID3v2Version.v3: [84, 77, 69, 68],
                                                                         ID3v2Version.v4: [84, 77, 69, 68]])

    public static let tmoo = ID3v2FrameID(nativeID: "TMOO", signatures: [ID3v2Version.v4: [84, 77, 79, 79]])

    public static let toal = ID3v2FrameID(nativeID: "TOAL", signatures: [ID3v2Version.v2: [84, 79, 84],
                                                                         ID3v2Version.v3: [84, 79, 65, 76],
                                                                         ID3v2Version.v4: [84, 79, 65, 76]])

    public static let tofn = ID3v2FrameID(nativeID: "TOFN", signatures: [ID3v2Version.v2: [84, 79, 70],
                                                                         ID3v2Version.v3: [84, 79, 70, 78],
                                                                         ID3v2Version.v4: [84, 79, 70, 78]])

    public static let toly = ID3v2FrameID(nativeID: "TOLY", signatures: [ID3v2Version.v2: [84, 79, 76],
                                                                         ID3v2Version.v3: [84, 79, 76, 89],
                                                                         ID3v2Version.v4: [84, 79, 76, 89]])

    public static let tope = ID3v2FrameID(nativeID: "TOPE", signatures: [ID3v2Version.v2: [84, 79, 65],
                                                                         ID3v2Version.v3: [84, 79, 80, 69],
                                                                         ID3v2Version.v4: [84, 79, 80, 69]])

    public static let tory = ID3v2FrameID(nativeID: "TORY", signatures: [ID3v2Version.v2: [84, 79, 82],
                                                                         ID3v2Version.v3: [84, 79, 82, 89]])

    public static let town = ID3v2FrameID(nativeID: "TOWN", signatures: [ID3v2Version.v3: [84, 79, 87, 78],
                                                                         ID3v2Version.v4: [84, 79, 87, 78]])

    public static let tpe1 = ID3v2FrameID(nativeID: "TPE1", signatures: [ID3v2Version.v2: [84, 80, 49],
                                                                         ID3v2Version.v3: [84, 80, 69, 49],
                                                                         ID3v2Version.v4: [84, 80, 69, 49]])

    public static let tpe2 = ID3v2FrameID(nativeID: "TPE2", signatures: [ID3v2Version.v2: [84, 80, 50],
                                                                         ID3v2Version.v3: [84, 80, 69, 50],
                                                                         ID3v2Version.v4: [84, 80, 69, 50]])

    public static let tpe3 = ID3v2FrameID(nativeID: "TPE3", signatures: [ID3v2Version.v2: [84, 80, 51],
                                                                         ID3v2Version.v3: [84, 80, 69, 51],
                                                                         ID3v2Version.v4: [84, 80, 69, 51]])

    public static let tpe4 = ID3v2FrameID(nativeID: "TPE4", signatures: [ID3v2Version.v2: [84, 80, 52],
                                                                         ID3v2Version.v3: [84, 80, 69, 52],
                                                                         ID3v2Version.v4: [84, 80, 69, 52]])

    public static let tpos = ID3v2FrameID(nativeID: "TPOS", signatures: [ID3v2Version.v2: [84, 80, 65],
                                                                         ID3v2Version.v3: [84, 80, 79, 83],
                                                                         ID3v2Version.v4: [84, 80, 79, 83]])

    public static let tpro = ID3v2FrameID(nativeID: "TPRO", signatures: [ID3v2Version.v4: [84, 80, 82, 79]])

    public static let tpub = ID3v2FrameID(nativeID: "TPUB", signatures: [ID3v2Version.v2: [84, 80, 66],
                                                                         ID3v2Version.v3: [84, 80, 85, 66],
                                                                         ID3v2Version.v4: [84, 80, 85, 66]])

    public static let trck = ID3v2FrameID(nativeID: "TRCK", signatures: [ID3v2Version.v2: [84, 82, 75],
                                                                         ID3v2Version.v3: [84, 82, 67, 75],
                                                                         ID3v2Version.v4: [84, 82, 67, 75]])

    public static let trda = ID3v2FrameID(nativeID: "TRDA", signatures: [ID3v2Version.v2: [84, 82, 68],
                                                                         ID3v2Version.v3: [84, 82, 68, 65]])

    public static let trsn = ID3v2FrameID(nativeID: "TRSN", signatures: [ID3v2Version.v3: [84, 82, 83, 78],
                                                                         ID3v2Version.v4: [84, 82, 83, 78]])

    public static let trso = ID3v2FrameID(nativeID: "TRSO", signatures: [ID3v2Version.v3: [84, 82, 83, 79],
                                                                         ID3v2Version.v4: [84, 82, 83, 79]])

    public static let tsoa = ID3v2FrameID(nativeID: "TSOA", signatures: [ID3v2Version.v4: [84, 83, 79, 65]])

    public static let tsop = ID3v2FrameID(nativeID: "TSOP", signatures: [ID3v2Version.v4: [84, 83, 79, 80]])

    public static let tsot = ID3v2FrameID(nativeID: "TSOT", signatures: [ID3v2Version.v4: [84, 83, 79, 84]])

    public static let tsiz = ID3v2FrameID(nativeID: "TSIZ", signatures: [ID3v2Version.v2: [84, 83, 73],
                                                                         ID3v2Version.v3: [84, 83, 73, 90]])

    public static let tsrc = ID3v2FrameID(nativeID: "TSRC", signatures: [ID3v2Version.v2: [84, 82, 67],
                                                                         ID3v2Version.v3: [84, 83, 82, 67],
                                                                         ID3v2Version.v4: [84, 83, 82, 67]])

    public static let tsse = ID3v2FrameID(nativeID: "TSSE", signatures: [ID3v2Version.v2: [84, 83, 83],
                                                                         ID3v2Version.v3: [84, 83, 83, 69],
                                                                         ID3v2Version.v4: [84, 83, 83, 69]])

    public static let tsst = ID3v2FrameID(nativeID: "TSST", signatures: [ID3v2Version.v4: [84, 83, 83, 84]])

    public static let tyer = ID3v2FrameID(nativeID: "TYER", signatures: [ID3v2Version.v2: [84, 89, 69],
                                                                         ID3v2Version.v3: [84, 89, 69, 82]])

    public static let txxx = ID3v2FrameID(nativeID: "TXXX", signatures: [ID3v2Version.v2: [84, 88, 88],
                                                                         ID3v2Version.v3: [84, 88, 88, 88],
                                                                         ID3v2Version.v4: [84, 88, 88, 88]])

    public static let ufid = ID3v2FrameID(nativeID: "UFID", signatures: [ID3v2Version.v2: [85, 70, 73],
                                                                         ID3v2Version.v3: [85, 70, 73, 68],
                                                                         ID3v2Version.v4: [85, 70, 73, 68]])

    public static let user = ID3v2FrameID(nativeID: "USER", signatures: [ID3v2Version.v3: [85, 83, 69, 82],
                                                                         ID3v2Version.v4: [85, 83, 69, 82]])

    public static let uslt = ID3v2FrameID(nativeID: "USLT", signatures: [ID3v2Version.v2: [85, 76, 84],
                                                                         ID3v2Version.v3: [85, 83, 76, 84],
                                                                         ID3v2Version.v4: [85, 83, 76, 84]])

    public static let wcom = ID3v2FrameID(nativeID: "WCOM", signatures: [ID3v2Version.v2: [87, 67, 77],
                                                                         ID3v2Version.v3: [87, 67, 79, 77],
                                                                         ID3v2Version.v4: [87, 67, 79, 77]])

    public static let wcop = ID3v2FrameID(nativeID: "WCOP", signatures: [ID3v2Version.v2: [87, 67, 80],
                                                                         ID3v2Version.v3: [87, 67, 79, 80],
                                                                         ID3v2Version.v4: [87, 67, 79, 80]])

    public static let woaf = ID3v2FrameID(nativeID: "WOAF", signatures: [ID3v2Version.v2: [87, 65, 70],
                                                                         ID3v2Version.v3: [87, 79, 65, 70],
                                                                         ID3v2Version.v4: [87, 79, 65, 70]])

    public static let woar = ID3v2FrameID(nativeID: "WOAR", signatures: [ID3v2Version.v2: [87, 65, 82],
                                                                         ID3v2Version.v3: [87, 79, 65, 82],
                                                                         ID3v2Version.v4: [87, 79, 65, 82]])

    public static let woas = ID3v2FrameID(nativeID: "WOAS", signatures: [ID3v2Version.v2: [87, 65, 83],
                                                                         ID3v2Version.v3: [87, 79, 65, 83],
                                                                         ID3v2Version.v4: [87, 79, 65, 83]])

    public static let wors = ID3v2FrameID(nativeID: "WORS", signatures: [ID3v2Version.v3: [87, 79, 82, 83],
                                                                         ID3v2Version.v4: [87, 79, 82, 83]])

    public static let wpay = ID3v2FrameID(nativeID: "WPAY", signatures: [ID3v2Version.v3: [87, 80, 65, 89],
                                                                         ID3v2Version.v4: [87, 80, 65, 89]])

    public static let wpub = ID3v2FrameID(nativeID: "WPUB", signatures: [ID3v2Version.v2: [87, 80, 66],
                                                                         ID3v2Version.v3: [87, 80, 85, 66],
                                                                         ID3v2Version.v4: [87, 80, 85, 66]])

    public static let wxxx = ID3v2FrameID(nativeID: "WXXX", signatures: [ID3v2Version.v2: [87, 88, 88],
                                                                         ID3v2Version.v3: [87, 88, 88, 88],
                                                                         ID3v2Version.v4: [87, 88, 88, 88]])

    public static let atxt = ID3v2FrameID(nativeID: "ATXT", signatures: [ID3v2Version.v3: [65, 84, 88, 84],
                                                                         ID3v2Version.v4: [65, 84, 88, 84]])

    public static let chap = ID3v2FrameID(nativeID: "CHAP", signatures: [ID3v2Version.v3: [67, 72, 65, 80],
                                                                         ID3v2Version.v4: [67, 72, 65, 80]])

    public static let ctoc = ID3v2FrameID(nativeID: "CTOC", signatures: [ID3v2Version.v3: [67, 84, 79, 67],
                                                                         ID3v2Version.v4: [67, 84, 79, 67]])

    // MARK: Instance Properties

    public let type: ID3v2FrameType
    public let name: String

    public let signatures: [ID3v2Version: [UInt8]]

    // MARK:

    public var hashValue: Int {
        var hash = 0

        if let signature = self.signatures[ID3v2Version.v2] {
            hash |= Int(signature[0])
        }

        if let signature = self.signatures[ID3v2Version.v3] {
            hash |= Int(signature[1]) << 8
        }

        if let signature = self.signatures[ID3v2Version.v4] {
            hash |= Int(signature[2]) << 16
        }

        return hash
    }

    // MARK: Initializers

    private init(type: ID3v2FrameType, name: String, signatures: [ID3v2Version: [UInt8]]) {
        assert((!name.isEmpty) && (!signatures.isEmpty), "Invalid name or signatures")

        self.type = type
        self.name = name

        self.signatures = signatures
    }

    private convenience init(nativeID name: String, signatures: [ID3v2Version: [UInt8]]) {
        self.init(type: ID3v2FrameType.native, name: name, signatures: signatures)
    }

    convenience init?(customID name: String, signatures: [ID3v2Version: [UInt8]]) {
        guard (!name.isEmpty) && (!signatures.isEmpty) else {
            return nil
        }

        for (version, signature) in signatures {
            guard ID3v2FrameID.checkSignature(signature, version: version) else {
                return nil
            }
        }

        self.init(type: ID3v2FrameType.custom, name: name, signatures: signatures)
    }

    // MARK: Type Methods

    public static func checkSignature(_ signature: [UInt8], version: ID3v2Version) -> Bool {
        switch version {
        case ID3v2Version.v2:
            if signature.count != 3 {
                return false
            }

        case ID3v2Version.v3:
            if signature.count != 4 {
                return false
            }

        case ID3v2Version.v4:
            if signature.count != 4 {
                return false
            }
        }

        for byte in signature {
            if (byte < 65) || (byte > 90) {
                if (byte < 48) || (byte > 57) {
                    return false
                }
            }
        }

        return true
    }
}

extension ID3v2FrameID: CustomStringConvertible {

    // MARK: Instance Properties

    public var description: String {
        switch self.type {
        case ID3v2FrameType.native:
            return self.name

        case ID3v2FrameType.custom:
            return "Custom: " + self.name
        }
    }
}

public func == (left: ID3v2FrameID, right: ID3v2FrameID) -> Bool {
    if left === right {
        return true
    }

    if left.signatures.count != right.signatures.count {
        return false
    }

    for (version, leftSignature) in left.signatures {
        if let rightSignature = right.signatures[version] {
            if rightSignature != leftSignature {
                return false
            }
        } else {
            return false
        }
    }

    return true
}

public func != (left: ID3v2FrameID, right: ID3v2FrameID) -> Bool {
    return !(left == right)
}
