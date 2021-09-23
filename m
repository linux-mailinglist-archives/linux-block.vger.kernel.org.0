Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063A4415BC5
	for <lists+linux-block@lfdr.de>; Thu, 23 Sep 2021 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbhIWKLB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Sep 2021 06:11:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 06:11:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D456422354;
        Thu, 23 Sep 2021 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632391768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugzVRDY4GJO3tkMDXbBZu2/7GmHRo380Iie1VN7S8nA=;
        b=G5uA/In7HQMqEfzBt+roWPVivoIgGjvuVYI+UuOL0b3028M7C0nQoA4UTKeDm0nNeNirp1
        SVpQjkbAuGkz/e4chZSRPpSb7NZWFj3/PdoaOcrmv8W55+SDAEPbjRmuWOmeDs+9f5wPcA
        Dq+Fm9V0AbZqJ6Ehy5f1igmDuqdcMMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632391768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugzVRDY4GJO3tkMDXbBZu2/7GmHRo380Iie1VN7S8nA=;
        b=i72M3Ab9PRVBtP9J+e/c8Kky/kRyjU+TPcQ9Kvl0w7RktpiBQ/uFnZSrJivEOQ0ZjJ4wzs
        AQeEXQUs5chSLoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E44313DCE;
        Thu, 23 Sep 2021 10:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMOiM1RSTGFMVQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 23 Sep 2021 10:09:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Coly Li" <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
        antlists@youngman.org.uk,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Hannes Reinecke" <hare@suse.de>, "Jens Axboe" <axboe@kernel.dk>,
        "Richard Fan" <richard.fan@suse.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        rafael@kernel.org
Subject: Re: Too large badblocks sysfs file (was: [PATCH v3 0/7] badblocks
 improvement for multiple bad block ranges)
In-reply-to: <a0f7b021-4816-6785-a9a4-507464b55895@suse.de>
References: <20210913163643.10233-1-colyli@suse.de>,
 <a0f7b021-4816-6785-a9a4-507464b55895@suse.de>
Date:   Thu, 23 Sep 2021 20:09:21 +1000
Message-id: <163239176137.2580.11220971146920860651@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMyBTZXAgMjAyMSwgQ29seSBMaSB3cm90ZToKPiBIaSBhbGwgdGhlIGtlcm5lbCBn
dXJ1cywgYW5kIGZvbGtzIGluIG1haWxpbmcgbGlzdHMsCj4gCj4gVGhpcyBpcyBhIHF1ZXN0aW9u
IGFib3V0IGV4cG9ydGluZyA0S0IrIHRleHQgaW5mb3JtYXRpb24gdmlhIHN5c2ZzIAo+IGludGVy
ZmFjZS4gSSBuZWVkIGFkdmljZSBvbiBob3cgdG8gaGFuZGxlIHRoZSBwcm9ibGVtLgoKV2h5IGRv
IHlvdSB0aGluayB0aGVyZSBpcyBhIHByb2JsZW0/CkFzIGRvY3VtZW50ZWQgaW4gRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9tZC5yc3QsIHRoZSB0cnVuY2F0aW9uIGF0IDEKcGFnZSBpcyBleHBl
Y3RlZCBhbmQgYnkgZGVzaWduLgoKVGhlICJ1bmFja25vd2xlZGdlLWJhZC1ibG9ja3MiIGZpbGUg
aXMgdGhlIGltcG9ydGFudCBvbmUgdGhhdCBpcyBuZWVkZWQKZm9yIGNvcnJlY3QgYmVoYXZpb3Vy
LiAgQmVpbmcgYWJsZSB0byByZWFkIGEgc2luZ2xlIGJsb2NrIGlzIHN1ZmZpY2llbnQsCnRob3Vn
aCBiZWluZyBhYmxlIHRvIHJlYWQgbW9yZSB0aGFuIG9uZSBjb3VsZCBwcm92aWRlIGJldHRlciBw
ZXJmb3JtYW5jZQppbiBzb21lIGNhc2VzLgoKVGhlICJiYWQtYmxvY2tzIiBmaWxlIHByaW1hcmls
eSBleGlzdCB0byBwcm92aWRlIHZpc2liaWxpdHkgaW50byB0aGUKc3RhdGUgb2YgdGhlIHN5c3Rl
bSAtIHVzZWZ1bCBkdXJpbmcgZGV2ZWxvcG1lbnQuICBJdCBjYW4gYmUgd3JpdHRlbiB0bwp0byBh
ZGQgYmFkIGJsb2Nrcy4gIEkgbmV2ZXIgKm5lZWRzKiB0byBiZSByZWFkIGZyb20uCgpUaGUgYXV0
aG9yaXRhdGl2ZSBzb3VyY2Ugb2YgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHNldCBvZiBiYWQgYmxv
Y2tzIGlzCnRoZSBvbi1kaXNrIGRhdGEgdGhlIGNhbiBiZSBhbmQgc2hvdWxkIGJlIHJlYWQgZGly
ZWN0bHkuLi4KCkV4Y2VwdCB0aGF0IG1kYWRtIGRvZXMuICBUaGF0IHdhcyBhIG1pc3Rha2UuICBj
aGVja19mb3JfY2xlYXJlZF9iYigpIGlzCndyb25nLiAgSSB3b25kZXIgd2h5IGl0IHdhcyBhZGRl
ZC4gIFRoZSBjb21taXQgbWVzc2FnZSBkb2Vzbid0IGdpdmUgYW55Cmp1c3RpZmljYXRpb24uCgpO
ZWlsQnJvd24KCgo+IAo+IFJlY2VudGx5IEkgd29yayBvbiB0aGUgYmFkIGJsb2NrcyBBUEkgKGJs
b2NrL2JhZGJsb2Nrcy5jKSBpbXByb3ZlbWVudCwgCj4gdGhlcmUgaXMgYSBzeXNmcyBmaWxlIHRv
IGV4cG9ydCB0aGUgYmFkIGJsb2NrIHJhbmdlcyBmb3IgbWUgcmFpZC4gRS5nIAo+IGZvciBhIG1k
IHJhaWQxIGRldmljZSwgZmlsZQo+ICDCoMKgwqAgL3N5cy9ibG9jay9tZDAvbWQvcmQwL2JhZF9i
bG9ja3MKPiBtYXkgY29udGFpbiB0aGUgZm9sbG93aW5nIHRleHQgY29udGVudCwKPiAgwqDCoMKg
IDY0IDMyCj4gIMKgwqAgMTI4IDgKPiBUaGUgYWJvdmUgbGluZXMgbWVhbiB0aGVyZSBhcmUgdHdv
IGJhZCBibG9jayByYW5nZXMsIG9uZSBzdGFydHMgYXQgTEJBIAo+IDY0LCBsZW5ndGggMzIgc2Vj
dG9ycywgYW5vdGhlciBvbmUgc3RhcnRzIGF0IExCQSAxMjggYW5kIGxlbmd0aCA4IAo+IHNlY3Rv
cnMuIEFsbCB0aGUgY29udGVudCBpcyBnZW5lcmF0ZWQgZnJvbSB0aGUgaW50ZXJuYWwgYmFkIGJs
b2NrIAo+IHJlY29yZHMgd2l0aCA1MTIgZWxlbWVudHMuIEluIG15IHRlc3RpbmcgdGhlIHdvcnN0
IGNhc2Ugb25seSAxODUgZnJvbSAKPiA1MTIgcmVjb3JkcyBjYW4gYmUgZGlzcGxheWVkIHZpYSB0
aGUgc3lzZnMgZmlsZSBpZiB0aGUgTEJBIHN0cmluZyBpcyAKPiB2ZXJ5IGxvbmcsIGUuZy50aGUg
Zm9sbG93aW5nIGNvbnRlbnQsCj4gIMKgIDE3NjY4MTY0MTM1MDMwNzc2IDUxMgo+ICDCoCAxNzY2
ODE2NDEzNTAyOTc3NiA1MTIKPiAgwqAgMTc2NjgxNjQxMzUwMjg3NzYgNTEyCj4gIMKgIDE3NjY4
MTY0MTM1MDI3Nzc2IDUxMgo+ICDCoCAuLi4gLi4uCj4gVGhlIGJhZCBibG9jayByYW5nZXMgc3Rv
cmVkIGluIGludGVybmFsIGJhZCBibG9ja3MgYXJyYXkgYXJlIGNvcnJlY3QsIAo+IGJ1dCB0aGUg
b3V0cHV0IG1lc3NhZ2UgaXMgdHJ1bmNhdGVkLiBUaGlzIGlzIHRoZSBwcm9ibGVtIEkgZW5jb3Vu
dGVyZWQuCj4gCj4gSSBkb24ndCBzZWUgc3lzZnMgaGFzIHNlcV9maWxlIHN1cHBvcnQgKGNvcnJl
Y3QgbWUgaWYgSSBhbSB3cm9uZyksIGFuZCBJIAo+IGtub3cgaXQgaXMgaW1wcm9wZXIgdG8gdHJh
bnNmZXIgNEtCKyB0ZXh0IHZpYSBzeXNmcyBpbnRlcmZhY2UsIGJ1dCB0aGUgCj4gY29kZSBpcyBo
ZXJlIGFscmVhZHkgZm9yIGxvbmcgdGltZS4KPiAKPiBUaGVyZSBhcmUgMiBpZGVhcyB0byBmaXgg
c2hvd2luZyB1cCBpbiBteSBicmFpbiwKPiAxKSBEbyBub3QgZml4IHRoZSBwcm9ibGVtCj4gIMKg
wqDCoCBOb3JtYWxseSBpdCBpcyByYXJlIHRoYXQgYSBzdG9yYWdlIG1lZGlhIGhhcyAxMDArIGJh
ZCBibG9jayByYW5nZXMsIAo+IG1heWJlIGluIHJlYWwgd29ybGQgYWxsIHRoZSBleGlzdGluZyBi
YWQgYmxvY2tzIGluZm9ybWF0aW9uIHdvbid0IGV4Y2VlZCAKPiB0aGUgcGFnZSBzaXplIGxpbWl0
YXRpb24gb2Ygc3lzZnMgZmlsZS4KPiAyKSBBZGQgc2VxX2ZpbGUgc3VwcG9ydCB0byBzeXNmcyBp
bnRlcmZhY2UgaWYgdGhlcmUgaXMgbm8KPiAKPiBJdCBpcyBwcm9iYWJseSB0aGVyZSBpcyBvdGhl
ciBiZXR0ZXIgc29sdXRpb24gdG8gZml4LiBTbyBJIGRvIHdhbnQgdG8gCj4gZ2V0IGhpbnQvYWR2
aWNlIGZyb20geW91Lgo+IAo+IFRoYW5rcyBpbiBhZHZhbmNlIGZvciBhbnkgY29tbWVudCA6LSkK
PiAKPiBDb2x5IExpCj4gCj4gT24gOS8xNC8yMSAxMjozNiBBTSwgQ29seSBMaSB3cm90ZToKPiA+
IFRoaXMgaXMgdGhlIHNlY29uZCBlZmZvcnQgdG8gaW1wcm92ZSBiYWRibG9ja3MgY29kZSBBUElz
IHRvIGhhbmRsZQo+ID4gbXVsdGlwbGUgcmFuZ2VzIGluIGJhZCBibG9jayB0YWJsZS4KPiA+Cj4g
PiBUaGVyZSBhcmUgMiBjaGFuZ2VzIGZyb20gcHJldmlvdXMgdmVyc2lvbiwKPiA+IC0gRml4ZXMg
MiBidWdzIGluIGZyb250X292ZXJ3cml0ZSgpIHdoaWNoIGFyZSBkZXRlY3RlZCBieSB0aGUgdXNl
cgo+ID4gICAgc3BhY2UgdGVzdGluZyBjb2RlLgo+ID4gLSBQcm92aWRlIHRoZSB1c2VyIHNwYWNl
IHRlc3RpbmcgY29kZSBpbiBsYXN0IHBhdGNoLgo+ID4KPiA+IFRoZXJlIGlzIE5PIGluLW1lbW9y
eSBvciBvbi1kaXNrIGZvcm1hdCBjaGFuZ2UgaW4gdGhlIHdob2xlIHNlcmllcywgYWxsCj4gPiBl
eGlzdGluZyBBUEkgYW5kIGRhdGEgc3RydWN0dXJlcyBhcmUgY29uc2lzdGVudC4gVGhpcyBzZXJp
ZXMganVzdCBvbmx5Cj4gPiBpbXByb3ZlIHRoZSBjb2RlIGFsZ29yaXRobSB0byBoYW5kbGUgbW9y
ZSBjb3JuZXIgY2FzZXMsIHRoZSBpbnRlcmZhY2VzCj4gPiBhcmUgc2FtZSBhbmQgY29uc2lzdGVu
Y3kgdG8gYWxsIGV4aXN0aW5nIGNhbGxlcnMgKG1kIHJhaWQgYW5kIG52ZGltbQo+ID4gZHJpdmVy
cykuCj4gPgo+ID4gVGhlIG9yaWdpbmFsIG1vdGl2YXRpb24gb2YgdGhlIGNoYW5nZSBpcyBmcm9t
IHRoZSByZXF1aXJlbWVudCBmcm9tIG91cgo+ID4gY3VzdG9tZXIsIHRoYXQgY3VycmVudCBiYWRi
bG9ja3Mgcm91dGluZXMgZG9uJ3QgaGFuZGxlIG11bHRpcGxlIHJhbmdlcy4KPiA+IEZvciBleGFt
cGxlIGlmIHRoZSBiYWQgYmxvY2sgc2V0dGluZyByYW5nZSBjb3ZlcnMgbXVsdGlwbGUgcmFuZ2Vz
IGZyb20KPiA+IGJhZCBibG9jayB0YWJsZSwgb25seSB0aGUgZmlyc3QgdHdvIGJhZCBibG9jayBy
YW5nZXMgbWVyZ2VkIGFuZCByZXN0ZWQKPiA+IHJhbmdlcyBhcmUgaW50YWN0LiBUaGUgZXhwZWN0
ZWQgYmVoYXZpb3Igc2hvdWxkIGJlIGFsbCB0aGUgY292ZXJlZAo+ID4gcmFuZ2VzIHRvIGJlIGhh
bmRsZWQuCj4gPgo+ID4gQWxsIHRoZSBwYXRjaGVzIGFyZSB0ZXN0ZWQgYnkgbW9kaWZpZWQgdXNl
ciBzcGFjZSBjb2RlIGFuZCB0aGUgY29kZQo+ID4gbG9naWMgd29ya3MgYXMgZXhwZWN0ZWQuIFRo
ZSBtb2RpZmllZCB1c2VyIHNwYWNlIHRlc3RpbmcgY29kZSBpcwo+ID4gcHJvdmlkZWQgaW4gbGFz
dCBwYXRjaC4gVGhlIHRlc3RpbmcgY29kZSBkZXRlY3RzIDIgZGVmZWN0cyBpbiBoZWxwZXIKPiA+
IGZyb250X292ZXJ3cml0ZSgpIGFuZCBmaXhlZCBpbiB0aGlzIHZlcnNpb24uCj4gPgo+ID4gVGhl
IHdob2xlIGNoYW5nZSBpcyBkaXZpZGVkIGludG8gNiBwYXRjaGVzIHRvIG1ha2UgdGhlIGNvZGUg
cmV2aWV3IG1vcmUKPiA+IGNsZWFyIGFuZCBlYXNpZXIuIElmIHBlb3BsZSBwcmVmZXIsIEknZCBs
aWtlIHRvIHBvc3QgYSBzaW5nbGUgbGFyZ2UKPiA+IHBhdGNoIGZpbmFsbHkgYWZ0ZXIgdGhlIGNv
ZGUgcmV2aWV3IGFjY29tcGxpc2hlZC4KPiA+Cj4gPiBUaGlzIHZlcnNpb24gaXMgc2VyaW91c2x5
IHRlc3RlZCwgYW5kIHNvIGZhciBubyBtb3JlIGRlZmVjdCBvYnNlcnZlZC4KPiA+Cj4gPgo+ID4g
Q29seSBMaQo+ID4KPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4KPiA+IENjOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPiA+IENjOiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+Cj4gPiBDYzogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPgo+
ID4gQ2M6IFJpY2hhcmQgRmFuIDxyaWNoYXJkLmZhbkBzdXNlLmNvbT4KPiA+IENjOiBWaXNoYWwg
TCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgo+ID4gLS0tCj4gPiBDaGFuZ2Vsb2c6
Cj4gPiB2MzogYWRkIHRlc3RlciBSaWNoYXJkIEZhbiA8cmljaGFyZC5mYW5Ac3VzZS5jb20+Cj4g
PiB2MjogdGhlIGltcHJvdmVkIHZlcnNpb24sIGFuZCB3aXRoIHRlc3RpbmcgY29kZS4KPiA+IHYx
OiB0aGUgZmlyc3QgY29tcGxldGVkIHZlcnNpb24uCj4gPgo+ID4KPiA+IENvbHkgTGkgKDYpOgo+
ID4gICAgYmFkYmxvY2tzOiBhZGQgbW9yZSBoZWxwZXIgc3RydWN0dXJlIGFuZCByb3V0aW5lcyBp
biBiYWRibG9ja3MuaAo+ID4gICAgYmFkYmxvY2tzOiBhZGQgaGVscGVyIHJvdXRpbmVzIGZvciBi
YWRibG9jayByYW5nZXMgaGFuZGxpbmcKPiA+ICAgIGJhZGJsb2NrczogaW1wcm92ZW1lbnQgYmFk
YmxvY2tzX3NldCgpIGZvciBtdWx0aXBsZSByYW5nZXMgaGFuZGxpbmcKPiA+ICAgIGJhZGJsb2Nr
czogaW1wcm92ZSBiYWRibG9ja3NfY2xlYXIoKSBmb3IgbXVsdGlwbGUgcmFuZ2VzIGhhbmRsaW5n
Cj4gPiAgICBiYWRibG9ja3M6IGltcHJvdmUgYmFkYmxvY2tzX2NoZWNrKCkgZm9yIG11bHRpcGxl
IHJhbmdlcyBoYW5kbGluZwo+ID4gICAgYmFkYmxvY2tzOiBzd2l0Y2ggdG8gdGhlIGltcHJvdmVk
IGJhZGJsb2NrIGhhbmRsaW5nIGNvZGUKPiA+IENvbHkgTGkgKDEpOgo+ID4gICAgdGVzdDogdXNl
ciBzcGFjZSBjb2RlIHRvIHRlc3QgYmFkYmxvY2tzIEFQSXMKPiA+Cj4gPiAgIGJsb2NrL2JhZGJs
b2Nrcy5jICAgICAgICAgfCAxNTk5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0KPiA+ICAgaW5jbHVkZS9saW51eC9iYWRibG9ja3MuaCB8ICAgMzIgKwo+ID4gICAyIGZpbGVz
IGNoYW5nZWQsIDEzNDAgaW5zZXJ0aW9ucygrKSwgMjkxIGRlbGV0aW9ucygtKQo+ID4KPiAKPiAK
