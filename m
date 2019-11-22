Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED902107662
	for <lists+linux-block@lfdr.de>; Fri, 22 Nov 2019 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKVRZJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Nov 2019 12:25:09 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:44211 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 12:25:08 -0500
Received: by mail-qk1-f182.google.com with SMTP id m16so6914300qki.11
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=x/t7YYwiNsScpRNZxre9kXNgeO6TrTQHVlcYwrBCrmw=;
        b=hgmkiI/tZFKNu2W5QdfvM49rKbFOs7bBlKXRcGQuWUpeB9HVnV7xPQvLfZFsHGrcgp
         /sLYsLft4o106guDCcDSTYez9sFUVFecJ71E7kyba4rIArbBT4iKkopzLMS36Go22kP5
         fcYXTTSuTWOZBRPy0ELYTiskw5s57Y8gPtMYmwYqvUaFcPBnJpKzQsAjtsjxB8lKr69s
         a7iq6JE3aUqT+o/Dr7lNJNSA3I+y4Q3ksVfYa9E2EhF3v6H47xgaTcNlzlbAVZ0fV5J/
         blbgb4ln/ZEjoNzLcybGwttpT9/wr0pflt3fK3tkzMWxqvn7oSZSzJ6LTXSKxNYU+Gha
         iGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=x/t7YYwiNsScpRNZxre9kXNgeO6TrTQHVlcYwrBCrmw=;
        b=NwRjuihOtNpHnhF86kp6m0zqhYNeYqjnxxwhOfwAMbgvNCuc3uHt1f4vLAT5sOtSyW
         gjkLLnab7IMZ+oYbcto6vm3rGCMvk05VJf4vsYHvsnWMFLTMtSNtfxqOBMn66nHdvYSU
         xtPRYRUG6PNqc96C8o8pajBK1Euf435UePSBeWTbBgUgcotkwsJxB0kvOtLn8wnUD0CK
         sbY/cem3cRjTVCh5iZYosC9k9s8/vn56g+OTvsP/IcGxs0E/seyRfcsyLJ8XjL8OvPt2
         tPLRCFzKocFYH0ukFL7mCid6vZmBcgL3ZmBJDmEZPBiOo8MnvTA2H3MzKA2UNDPdZ2up
         isoQ==
X-Gm-Message-State: APjAAAWc1pOhxLJ4tPjAe1m5xjCsXR9PU9qITzwK69fHLn/KcV2eMPPz
        rnNUv29sn6fqcZhkqVUMnaaw8A==
X-Google-Smtp-Source: APXvYqx99CvvuJPnYd+Rq7afdv0vTgv7dWSgTIm3gn4xoBOvZhWu0Jdh2wyfyVQMdyNPJWGIaahWcw==
X-Received: by 2002:a05:620a:13d1:: with SMTP id g17mr14227390qkl.313.1574443505421;
        Fri, 22 Nov 2019 09:25:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::64e2])
        by smtp.gmail.com with ESMTPSA id v189sm3302167qkc.37.2019.11.22.09.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 09:25:04 -0800 (PST)
Date:   Fri, 22 Nov 2019 12:25:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2020: Call for Proposals
Message-ID: <20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2020 will be held from April 27 - April 29 at
The Riviera Palm Springs, A Tribute Portfolio Resort in Palm Springs,
California. LSF/MM/BPF is an invitation-only technical workshop to map
out improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

LSF/MM/BPF 2020 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic
as soon as possible.

This year will be a little different for requesting attendance.  Please
do the following by February 15th, 2020.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/voWi1j9kDs13Lyqf9

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

	Josef Bacik (Filesystems)
	Amir Goldstein (Filesystems)
	Martin K. Petersen (Storage)
	Omar Sandoval (Storage)
	Michal Hocko (MM)
	Dan Williams (MM)
	Alexei Starovoitov (BPF)
	Daniel Borkmann (BPF)
