Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE4CDE0E
	for <lists+linux-block@lfdr.de>; Mon,  7 Oct 2019 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfJGJMk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Oct 2019 05:12:40 -0400
Received: from filter02-out9.totaalholding.nl ([185.56.145.241]:60915 "EHLO
        filter02-out9.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbfJGJMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 05:12:40 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHP4H-0001aF-M6
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 11:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7niSvnIjBwT5WLG6zsc4NZ+LnvL9I6gl7mchhN6UUY=; b=K3iZg25wplXBOBcFA6Z/D3dkgq
        6YA0T1RG00siQE+EsTl3h+sCe9G3eN1s4YhN4pMdsKbg5hFCtEU84+N5DGrjVeXcXKCozWq/M4VI2
        8NrWPLG1V2h6GnYjhwN1W8NbkrkMCidCtpNDV5EnlcEeuF8GuYSG7juxujjIDdNg+cLJv3wy0uOXF
        8GC75Yo1iGELm9b5AeChrR9bwFcvmsLT6ug8JiFruKBgqEZ/tiiBsH+8j/eGUHEHakQ4AQ/ZhlNAC
        oSvPd04uDJcqIKJpGr2VLHP/jYTyunfSI4tZoHFQhJ+BHzC+AUO0G5UwtXfMEV8mJ5aRjRYVTxsgG
        cKp8oc8Q==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60202 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHP4H-0002o2-T8; Mon, 07 Oct 2019 11:12:37 +0200
Message-ID: <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 11:11:05 +0200
In-Reply-To: <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
         <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
         <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
         <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
         <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
         <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.linux-block@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.linux-block@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.27)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVC0bIZKK1nltB
 DSBkPkBVrUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2mFamqyY8EhtUDs1Z+Bl9NTg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XA+ln3SmdyWNNJvR4I+Hp8ZWNeKErwtwuMGNtXyijhL/j8
 275EN0QRns1uAvLg7hc/40qb4TUExMY1tJeDazGHT9VnAwYmYPhCtjQveFc/ttqzpjogZOIQLFqr
 QNK2b8/y4JRq3UYHEt22IvIMKBSTlfO+aaj6wnK9h39sR8Y3Dzu1X2iVNki8izWZuQRxhjw0T1+z
 /gVqUXbO3Yb0X5mHnJOk/4zIFAxXcQPb3cDitjIVvcJ3q2OXJ6p7McvevdFmF7I6vAoqMu7bH6bh
 5Tn1+ApfpnfqaBDETpAVW0am1AftxOzzT/YWdmD8gywgB151uK+wsnvd2XRh79oPsqvurHLa/P4e
 zC06EoqeDuStmICc1mvxWkfhDNLhFrRgdcJncNLOj0gyfC+E+JhwuM2loN6g5fMPPHW04q0LBG3v
 ooS/KWL2TW1pyb+uOnvvAx7DvnjL6OI0XUlLzsHhA6/79TEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-07 at 10:45 +0200, Hannes Reinecke wrote:
> On 10/7/19 10:07 AM, Mischa Baars wrote:
> > On Mon, 2019-10-07 at 09:23 +0200, Hannes Reinecke wrote:
> > > On 10/7/19 9:02 AM, Mischa Baars wrote:
> > > > On Sun, 2019-10-06 at 09:10 -0600, Jens Axboe wrote:
> > > [ .. ]
> > > > > I'm saying that you are comparing apples to oranges. The floppy driver
> > > > > might be older tech, but it's much more used than pktcdvd. It's not the
> > > > > case that we must pick one over the other, in terms of what stays and
> > > > > what goes.
> > > > > 
> > > > 
> > > > Yes we are, sort of. You can even have my pear. That's exactly the problem with your story :)
> > > > 
> > > > A DVD is 4Gb and Blueray goes all the way up to 100Gb, while a floppy disc is 1.44Mb.
> > > > Who would want to write his backup files to 1.44Mb floppy disc these days?
> > > > 
> > > Why do you keep on bringing up floppy?
> > > I was under the impression that you wanted to use pktdvd, not floppy...
> > > And as Jens made it clear, any potential removal of the floppy driver
> > > will have _zero_ influence on the future of pktdvd.
> > 
> > I do not keep bringing up the floppy drives. I'm merely trying to point
> > out that removing the floppy driver is the more logical course of action.
> > 
> ??
> 
> > Also, you must be mistaken. It's not about the potential removal of the
> > floppy driver, it's about the removal of the packet writing driver. There
> > will be no pktcdvd kernel module in the future. To be precise, both reading
> > and writing dvd's is already unsupported in the latest linux-next kernel.
> > 
> I know what pktcddvd is, and I know what it's used for.
> All what Jens has been complaining is that the code has been
> unmaintained for quite a while, and only very few bugfixes coming in.
> Which typically indicates that there are only very few users left, if any.

Well, I was using it :(

Hope that isn't any problem?

> > > And in either case, the main question here was:
> > > Will you rebase your project to latest mainline once it's ready?
> > > Or will you settle on a kernel version to do your development on, and
> > > continue using that for your project?
> > 
> > No, the code is intended for companies like AMD, Intel or ARM. It
> > is not indended for the opensource community. Does that mean that
> > I cannot develop on an opensource platform? Is that you are trying to tell me?
> > 
> No.
> What we are trying to tell you is that:
> a) The code is unmaintained, and (as of now) there hadn't been anyone
> expressing an interest. If you require this driver for your project,
> send a mail to Jens Axboe that you are willing to take over
> maintainership for this driver. Then you get to decide if and when the
> driver should be obsoleted. You'll be responsible for fixing issues with
> that driver, true, but to quote the brexit axiom: you can't have the
> cake and eat it ...
> b) The underlying hardware is becoming obsolete. SCSI CD-ROM drivers are
> a thing of the past, and ATAPI hardware is on its way to be replaced
> with USB Flash. Case in point: ATAPI support got dropped from the ATA
> spec ACS-4, and most laptops nowadays don't even have a DVD slot
> anymore. Hence I would question the need for DVD support in the future.
> Unless, of course, you do happen to work for a company producing said
> devices, in which case I would strongly recommend going for a) above.

b) My point exactly, CD, DVD and Blueray is being replaced by USB Flash. The problem is, as you can read in my first mail, is that USB is rewritable. Also, I
can't even image that 100Gb Blueray is a thing of the past. Slots can be replaced by USB, but that doesn't make the writer obsolete.

No, I don't work for any company producing dvd and blueray drives.

a) If necesarry I could do the maintaining, sure.

> > > Incidentally: I _do_ know of one company who happily will provide you
> > > with a stable OS to base your development on ... three, actually ...
> > 
> > You would like me to work with Microsoft products, don't you?
> > 
> Look at my signature. No.
> 
> Cheers,
> 
> Hannes

