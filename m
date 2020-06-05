Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2B1EFBFE
	for <lists+linux-block@lfdr.de>; Fri,  5 Jun 2020 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgFEO6p (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Jun 2020 10:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgFEO6o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D56D7B484;
        Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD7E21E1281; Fri,  5 Jun 2020 16:58:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if enabling multiple traces
Date:   Fri,  5 Jun 2020 16:58:35 +0200
Message-Id: <20200605145349.18454-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

this series contains a patch from Luis' blktrace series and then my patch
to fix sparse warnings in blktrace. Luis' patch stands on its own, was
reviewed, and changes what I need to change as well so I've decided it's just
simplest to pull it in with my patch.

								Honza
