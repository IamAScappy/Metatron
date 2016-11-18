//
//  ID3v2FrameRegistry.swift
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

public class ID3v2FrameRegistry {

	// MARK: Type Properties

    public static let regular = ID3v2FrameRegistry()

    // MARK: Instance Properties

    public private(set) var nativeIDs: [String: ID3v2FrameID]
    public private(set) var customIDs: [String: ID3v2FrameID]

    public private(set) var stuffs: [ID3v2FrameID: ID3v2FrameStuffFormat]

    // MARK: Initializers

    private init() {
        self.nativeIDs = ["AENC": ID3v2FrameID.aenc,
						  "APIC": ID3v2FrameID.apic,
						  "ASPI": ID3v2FrameID.aspi,

						  "COMM": ID3v2FrameID.comm,
						  "COMR": ID3v2FrameID.comr,

						  "CRM": ID3v2FrameID.crm,

						  "ENCR": ID3v2FrameID.encr,
						  "EQUA": ID3v2FrameID.equa,
						  "EQU2": ID3v2FrameID.equ2,
						  "ETCO": ID3v2FrameID.etco,

						  "GEOB": ID3v2FrameID.geob,
						  "GRID": ID3v2FrameID.grid,

						  "IPLS": ID3v2FrameID.ipls,

						  "LINK": ID3v2FrameID.link,

						  "MCDI": ID3v2FrameID.mcdi,
						  "MLLT": ID3v2FrameID.mllt,

						  "OWNE": ID3v2FrameID.owne,

						  "PRIV": ID3v2FrameID.priv,
						  "PCNT": ID3v2FrameID.pcnt,
						  "POPM": ID3v2FrameID.popm,
						  "POSS": ID3v2FrameID.poss,

						  "RBUF": ID3v2FrameID.rbuf,
						  "RVAD": ID3v2FrameID.rvad,
						  "RVA2": ID3v2FrameID.rva2,
						  "RVRB": ID3v2FrameID.rvrb,

						  "SEEK": ID3v2FrameID.seek,
						  "SIGN": ID3v2FrameID.sign,
						  "SYLT": ID3v2FrameID.sylt,
						  "SYTC": ID3v2FrameID.sytc,

						  "TALB": ID3v2FrameID.talb,
						  "TBPM": ID3v2FrameID.tbpm,
						  "TCOM": ID3v2FrameID.tcom,
						  "TCON": ID3v2FrameID.tcon,
						  "TCOP": ID3v2FrameID.tcop,
						  "TDEN": ID3v2FrameID.tden,
						  "TDAT": ID3v2FrameID.tdat,
						  "TDLY": ID3v2FrameID.tdly,
						  "TDOR": ID3v2FrameID.tdor,
						  "TDRC": ID3v2FrameID.tdrc,
						  "TDRL": ID3v2FrameID.tdrl,
						  "TDTG": ID3v2FrameID.tdtg,
						  "TENC": ID3v2FrameID.tenc,
						  "TEXT": ID3v2FrameID.text,
						  "TFLT": ID3v2FrameID.tflt,
						  "TIPL": ID3v2FrameID.tipl,
						  "TIME": ID3v2FrameID.time,
						  "TIT1": ID3v2FrameID.tit1,
						  "TIT2": ID3v2FrameID.tit2,
						  "TIT3": ID3v2FrameID.tit3,
						  "TKEY": ID3v2FrameID.tkey,
						  "TLAN": ID3v2FrameID.tlan,
						  "TLEN": ID3v2FrameID.tlen,
						  "TMCL": ID3v2FrameID.tmcl,
						  "TMED": ID3v2FrameID.tmed,
						  "TMOO": ID3v2FrameID.tmoo,
						  "TOAL": ID3v2FrameID.toal,
						  "TOFN": ID3v2FrameID.tofn,
						  "TOLY": ID3v2FrameID.toly,
						  "TOPE": ID3v2FrameID.tope,
						  "TORY": ID3v2FrameID.tory,
						  "TOWN": ID3v2FrameID.town,
						  "TPE1": ID3v2FrameID.tpe1,
						  "TPE2": ID3v2FrameID.tpe2,
						  "TPE3": ID3v2FrameID.tpe3,
						  "TPE4": ID3v2FrameID.tpe4,
						  "TPOS": ID3v2FrameID.tpos,
						  "TPRO": ID3v2FrameID.tpro,
						  "TPUB": ID3v2FrameID.tpub,
						  "TRCK": ID3v2FrameID.trck,
						  "TRDA": ID3v2FrameID.trda,
						  "TRSN": ID3v2FrameID.trsn,
						  "TRSO": ID3v2FrameID.trso,
						  "TSOA": ID3v2FrameID.tsoa,
						  "TSOP": ID3v2FrameID.tsop,
						  "TSOT": ID3v2FrameID.tsot,
						  "TSIZ": ID3v2FrameID.tsiz,
						  "TSRC": ID3v2FrameID.tsrc,
						  "TSSE": ID3v2FrameID.tsse,
						  "TSST": ID3v2FrameID.tsst,
						  "TYER": ID3v2FrameID.tyer,
						  "TXXX": ID3v2FrameID.txxx,

						  "UFID": ID3v2FrameID.ufid,
						  "USER": ID3v2FrameID.user,
						  "USLT": ID3v2FrameID.uslt,

						  "WCOM": ID3v2FrameID.wcom,
						  "WCOP": ID3v2FrameID.wcop,
						  "WOAF": ID3v2FrameID.woaf,
						  "WOAR": ID3v2FrameID.woar,
						  "WOAS": ID3v2FrameID.woas,
						  "WORS": ID3v2FrameID.wors,
						  "WPAY": ID3v2FrameID.wpay,
						  "WPUB": ID3v2FrameID.wpub,
						  "WXXX": ID3v2FrameID.wxxx,

						  "ATXT": ID3v2FrameID.atxt,
						  "CHAP": ID3v2FrameID.chap,
						  "CTOC": ID3v2FrameID.ctoc]

        self.customIDs = [:]

        self.stuffs = [ID3v2FrameID.aenc: ID3v2AudioEncryptionFormat.regular,
        			   ID3v2FrameID.apic: ID3v2AttachedPictureFormat.regular,

                       ID3v2FrameID.comm: ID3v2CommentsFormat.regular,

        			   ID3v2FrameID.encr: ID3v2FeatureRegistrationFormat.regular,
                       ID3v2FrameID.etco: ID3v2EventTimingCodesFormat.regular,

        			   ID3v2FrameID.grid: ID3v2FeatureRegistrationFormat.regular,

                       ID3v2FrameID.ipls: ID3v2InvolvedPeopleListFormat.regular,

                       ID3v2FrameID.pcnt: ID3v2PlayCounterFormat.regular,
                       ID3v2FrameID.popm: ID3v2PopularimeterFormat.regular,

                       ID3v2FrameID.sign: ID3v2FeatureSignatureFormat.regular,
                       ID3v2FrameID.sylt: ID3v2SyncedLyricsFormat.regular,
                       ID3v2FrameID.sytc: ID3v2SyncedTempoCodesFormat.regular,

        			   ID3v2FrameID.talb: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tbpm: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tcom: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tcon: ID3v2ContentTypeFormat.regular,
        			   ID3v2FrameID.tcop: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tden: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdat: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdly: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdor: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdrc: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdrl: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tdtg: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tenc: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.text: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tflt: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tipl: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.time: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tit1: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tit2: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tit3: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tkey: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tlan: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tlen: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tmcl: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tmed: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tmoo: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.toal: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tofn: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.toly: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tope: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tory: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.town: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpe1: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpe2: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpe3: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpe4: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpos: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpro: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tpub: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.trck: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.trda: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.trsn: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.trso: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsoa: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsop: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsot: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsiz: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsrc: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsse: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tsst: ID3v2TextInformationFormat.regular,
        			   ID3v2FrameID.tyer: ID3v2TextInformationFormat.regular,
                       ID3v2FrameID.txxx: ID3v2UserTextInformationFormat.regular,

                       ID3v2FrameID.wcom: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.wcop: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.woaf: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.woar: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.woas: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.wors: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.wpay: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.wpub: ID3v2URLLinkFormat.regular,
                       ID3v2FrameID.wxxx: ID3v2UserURLLinkFormat.regular,

                       ID3v2FrameID.user: ID3v2TermsOfUseFormat.regular,
                       ID3v2FrameID.uslt: ID3v2UnsyncedLyricsFormat.regular,
        			   ID3v2FrameID.ufid: ID3v2UniqueFileIdentifierFormat.regular]
    }

    // MARK: Instance Methods

    public func identifySignature(_ signature: [UInt8], version: ID3v2Version) -> ID3v2FrameID? {
        guard !signature.isEmpty else {
            return nil
        }

        for (_, customID) in self.customIDs {
            if let customSignature = customID.signatures[version] {
                if customSignature == signature {
                    return customID
                }
            }
        }

        for (_, nativeID) in self.nativeIDs {
            if let nativeSignature = nativeID.signatures[version] {
                if nativeSignature == signature {
                    return nativeID
                }
            }
        }

        if (version == ID3v2Version.v3) && (signature.count == 4) && (signature[3] == 0) {
            let signaturePrefix = [UInt8](signature.prefix(3))

            for (_, nativeID) in self.nativeIDs {
                if let nativeSignature = nativeID.signatures[ID3v2Version.v2] {
                    if nativeSignature == signaturePrefix {
                        return nativeID
                    }
                }
            }
        }

        guard let identifier = String(bytes: signature, encoding: String.Encoding.isoLatin1) else {
            return nil
        }

        return ID3v2FrameID(customID: identifier, signatures: [version: signature])
    }

    @discardableResult
    public func registerCustomID(_ name: String, signatures: [ID3v2Version: [UInt8]]) -> ID3v2FrameID? {
        guard self.customIDs[name] == nil else {
            return nil
        }

        for (version, signature) in signatures {
            for (_, customID) in self.customIDs {
                if let customSignature = customID.signatures[version] {
                    guard customSignature != signature else {
                        return nil
                    }
                }
            }
        }

        guard let customID = ID3v2FrameID(customID: name, signatures: signatures) else {
            return nil
        }

        self.customIDs[name] = customID

        return customID
    }

    @discardableResult
    public func registerStuff(format: ID3v2FrameStuffFormat, identifier: ID3v2FrameID) -> Bool {
        guard self.stuffs[identifier] == nil else {
            return false
        }

        self.stuffs[identifier] = format

        return true
    }
}
