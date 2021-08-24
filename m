Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F793F5C82
	for <lists+linux-block@lfdr.de>; Tue, 24 Aug 2021 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhHXK5J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Aug 2021 06:57:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhHXK5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 06:57:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCD24220C7;
        Tue, 24 Aug 2021 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629802583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=CLQ5LRkCAUHdpOjMD6UCE/qgR2x0+lYuAsaFLX+AyZI=;
        b=cHbhO+8xvTOzQMAn6Ynh2mrBOsXXsclPudSDH/nb1g4Tt6IEFjYOm4O3Woif/dT+H3FxlP
        wO8L2w+a0CdUJx2ot57K/Gg6qMU9LaqXQe0v1oMrvggugKxk8xK1m55XFmPrz46vaEpKFm
        n3+Y2AlurdJFZ3K35AP76Oops/10I10=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B919D137F3;
        Tue, 24 Aug 2021 10:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id l52oLFfQJGHOFAAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 24 Aug 2021 10:56:23 +0000
Date:   Tue, 24 Aug 2021 12:56:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: BFQ cgroup weights range
Message-ID: <20210824105626.GA11367@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

The default weight for proportional IO control associated with a cgroup
is 100 [1]. The minimum allowed weight is 1 [2] and the maximum weight
1000 [3].  This is a bit inconsistent with general cgroup weight
semantic where def/min == max/def (i.e. symmetric adjustments to both
sides) [4].

1) Is there a reason why the maximum allowed weight is (only) 1000?
   (E.g. it won't be possible to ensure 10^4 ratio of proportional
   control but 10^3 is achievable.)
2) Is the default value 100 special or absolute in a sense? (I suspect
   it is, the unchangeable weight of root cgroup members. Therefore two
   siblings with equal ratios 10:100 and 100:1000 would behave same only
   when there's no interfering IO from the root.)

Thanks,
Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bfq-cgroup.c?h=v5.14-rc7#n513
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bfq-iosched.h?h=v5.14-rc7#n18
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bfq-iosched.h?h=v5.14-rc7#n19
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/cgroup-v2.rst?h=v5.14-rc7#n602
